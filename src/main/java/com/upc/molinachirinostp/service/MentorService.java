package com.upc.molinachirinostp.service;

import com.upc.molinachirinostp.dto.RegistrarMentorDTO;
import com.upc.molinachirinostp.entity.*;
import com.upc.molinachirinostp.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MentorService {
    private final MentorRepository mentorRepo;
    private final UsuarioRepository usuarioRepo;
    private final HabilidadRepository habilidadRepo;
    private final MentorHabilidadRepository mentorHabRepo;
    private final JdbcTemplate jdbcTemplate;

    public List<Mentor> obtenerTodos() {
        return mentorRepo.findAll();
    }

    public List<Mentor> obtenerTodosExceptoUsuarioActual() {
        List<Mentor> todosMentores = mentorRepo.findAll();
        System.out.println("Total mentores en BD: " + todosMentores.size());
        
        // Obtener el email del usuario autenticado
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null) {
            System.out.println("No hay autenticación, retornando todos los mentores");
            return todosMentores;
        }
        
        String emailUsuarioActual = auth.getName();
        System.out.println("Email usuario actual: " + emailUsuarioActual);
        
        // Buscar el usuario por email
        Usuario usuarioActual = usuarioRepo.findByEmail(emailUsuarioActual)
                .orElse(null);
        
        if (usuarioActual == null) {
            System.out.println("Usuario actual no encontrado, retornando todos los mentores");
            return todosMentores;
        }
        
        System.out.println("ID usuario actual: " + usuarioActual.getIdUser());
        
        // Debug: mostrar todos los mentores
        for (Mentor m : todosMentores) {
            System.out.println("Mentor ID: " + m.getIdMentor() + 
                             ", Usuario: " + (m.getUsuario() != null ? m.getUsuario().getIdUser() : "NULL"));
        }
        
        // Retornar todos los mentores excepto el usuario actual
        List<Mentor> mentoresFiltrados = todosMentores.stream()
                .filter(mentor -> mentor.getUsuario() != null && 
                        !mentor.getUsuario().getIdUser().equals(usuarioActual.getIdUser()))
                .toList();
        
        System.out.println("Mentores después del filtro: " + mentoresFiltrados.size());
        return mentoresFiltrados;
    }

    public Mentor obtenerPorId(Long idMentor) {
        return mentorRepo.findById(idMentor)
                .orElseThrow(() -> new IllegalArgumentException("mentor not found"));
    }

    public Mentor crear(Long idUser, String bio){
        Usuario u = usuarioRepo.findById(idUser)
                .orElseThrow(() -> new IllegalArgumentException("usuario not found"));
        Mentor m = new Mentor();
        m.setUsuario(u);
        m.setBio(bio);
        return mentorRepo.save(m);
    }

    // Crear mentor desde objeto Mentor (para formulario de registro)
    public Mentor crearMentor(Mentor mentor) {
        System.out.println("🔴 USANDO MÉTODO INCORRECTO: crearMentor()");
        System.out.println("  - mentor.getUsuario(): " + mentor.getUsuario());
        System.out.println("  - mentor.getIdUser(): " + mentor.getIdUser());
        
        if (mentor.getUsuario() != null && mentor.getUsuario().getIdUser() != null) {
            Usuario u = usuarioRepo.findById(mentor.getUsuario().getIdUser())
                    .orElseThrow(() -> new IllegalArgumentException("Usuario no encontrado"));
            mentor.setUsuario(u);
            mentor.setIdUser(u.getIdUser());  // Establecer también el campo directo
            System.out.println("✅ Usuario encontrado y asignado: " + u.getIdUser());
        } else {
            System.out.println("⚠️ Usuario es NULL o no tiene ID");
        }
        
        Mentor saved = mentorRepo.save(mentor);
        System.out.println("💾 Mentor guardado - ID: " + saved.getIdMentor() + ", idUser: " + saved.getIdUser());
        return saved;
    }

    // Crear mentor usando DTO
    @Transactional
    public Mentor crearMentorConDTO(RegistrarMentorDTO dto) {
        System.out.println("🔍 Buscando usuario con ID: " + dto.usuarioId());
        Usuario usuario = usuarioRepo.findById(dto.usuarioId())
                .orElseThrow(() -> new IllegalArgumentException("Usuario no encontrado"));
        
        System.out.println("✅ Usuario encontrado: " + usuario.getEmail() + " (ID: " + usuario.getIdUser() + ")");
        
        Mentor mentor = new Mentor();
        mentor.setIdUser(usuario.getIdUser());  // Establecer FK directamente
        mentor.setUsuario(usuario);             // Para la relación JPA
        mentor.setBio(dto.bio());
        mentor.setAreasExperiencia(dto.areasExperiencia());
        mentor.setAnosExperiencia(dto.anosExperiencia());
        mentor.setTarifaHora(dto.tarifaHora());
        mentor.setDisponible(dto.disponible() != null ? dto.disponible() : true);
        
        System.out.println("💾 ANTES DE GUARDAR:");
        System.out.println("  - mentor.getIdUser(): " + mentor.getIdUser());
        System.out.println("  - mentor.getUsuario().getIdUser(): " + mentor.getUsuario().getIdUser());
        
        Mentor saved = mentorRepo.save(mentor);
        
        System.out.println("✅ DESPUÉS DE GUARDAR:");
        System.out.println("  - saved.getIdMentor(): " + saved.getIdMentor());
        System.out.println("  - saved.getIdUser(): " + saved.getIdUser());
        System.out.println("  - saved.getUsuario(): " + (saved.getUsuario() != null ? saved.getUsuario().getIdUser() : "NULL"));
        
        // FALLBACK: Si el id_user sigue siendo NULL, actualizarlo directamente
        if (saved.getIdUser() == null) {
            System.out.println("⚠️ FALLBACK: Actualizando id_user directamente con SQL");
            jdbcTemplate.update("UPDATE mentor SET id_user = ? WHERE id_mentor = ?", 
                              usuario.getIdUser(), saved.getIdMentor());
            saved.setIdUser(usuario.getIdUser());
        }
        
        return saved;
    }

    @Transactional
    public MentorHabilidad agregarHabilidad(Long idMentor, Long idHabilidad, LocalDate desde){
        Mentor mentor = mentorRepo.findById(idMentor)
                .orElseThrow(() -> new IllegalArgumentException("mentor not found"));
        Habilidad hab = habilidadRepo.findById(idHabilidad)
                .orElseThrow(() -> new IllegalArgumentException("habilidad not found"));
        MentorHabilidad mh = new MentorHabilidad(null, mentor, hab, desde);
        return mentorHabRepo.save(mh);
    }

    public Mentor obtenerPorIdUsuario(Long idUsuario) {
        return mentorRepo.findByUsuario_IdUser(idUsuario)
                .orElseThrow(() -> new IllegalArgumentException("Mentor no encontrado para este usuario"));
    }

    // Verificar si un usuario es mentor
    public boolean esUsuarioMentor(Long idUsuario) {
        return mentorRepo.findByUsuario_IdUser(idUsuario).isPresent();
    }

}
