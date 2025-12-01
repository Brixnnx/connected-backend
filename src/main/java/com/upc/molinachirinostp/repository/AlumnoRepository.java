package com.upc.molinachirinostp.repository;

import com.upc.molinachirinostp.entity.Alumno;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AlumnoRepository extends JpaRepository<Alumno, Long> {
    Optional<Alumno> findByUsuario_IdUser(Long idUser);
}
