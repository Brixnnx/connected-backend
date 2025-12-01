package com.upc.molinachirinostp.repository;

import com.upc.molinachirinostp.entity.SesionMentoria;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;

public interface SesionMentoriaRepository extends JpaRepository<SesionMentoria, Long> {
    // HU: listar sesiones de un alumno en una fecha (de tu TP)
    List<SesionMentoria> findByAlumnoIdAlumnoAndFechaInicio(Long idAlumno, LocalDate fecha);
    
    // Listar sesiones de un alumno desde una fecha en adelante
    List<SesionMentoria> findByAlumnoIdAlumnoAndFechaInicioGreaterThanEqual(Long idAlumno, LocalDate fechaDesde);
}
