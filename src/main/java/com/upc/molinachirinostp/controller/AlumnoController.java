package com.upc.molinachirinostp.controller;

import com.upc.molinachirinostp.entity.Alumno;
import com.upc.molinachirinostp.service.AlumnoService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/connected/alumnos")
@RequiredArgsConstructor
@PreAuthorize("hasAnyAuthority('ROLE_USER', 'ROLE_MENTOR', 'ROLE_ADMIN')")
public class AlumnoController {

    private final AlumnoService alumnoService;

    // Registrarse como alumno
    @PostMapping
    public Alumno registrarseAlumno(@RequestBody Alumno alumno) {
        return alumnoService.crearAlumno(alumno);
    }

    // Obtener todos los alumnos
    @GetMapping
    public List<Alumno> obtenerTodos() {
        return alumnoService.obtenerTodos();
    }

    // Obtener un alumno por ID
    @GetMapping("/{idAlumno}")
    public Alumno obtenerPorId(@PathVariable Long idAlumno) {
        return alumnoService.obtenerPorId(idAlumno);
    }

    // Obtener alumno por ID de usuario
    @GetMapping("/usuario/{idUsuario}")
    public Alumno obtenerPorIdUsuario(@PathVariable Long idUsuario) {
        return alumnoService.obtenerPorIdUsuario(idUsuario);
    }
}
