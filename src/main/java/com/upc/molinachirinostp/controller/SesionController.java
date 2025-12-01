package com.upc.molinachirinostp.controller;

import com.upc.molinachirinostp.dto.CrearSesionDTO;
import com.upc.molinachirinostp.dto.SesionViewDTO;
import com.upc.molinachirinostp.service.SesionService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/connected")
@RequiredArgsConstructor
@PreAuthorize("hasAnyAuthority('ROLE_USER', 'ROLE_MENTOR', 'ROLE_ADMIN')")
public class SesionController {

    private final SesionService sesionService;

    // Crear sesión (usa DTO de entrada y devuelve DTO de salida)
    @PostMapping("/sesiones")
    public SesionViewDTO crear(@RequestBody @Valid CrearSesionDTO dto) {
        return sesionService.crear(dto);
    }

    // Listar sesiones por usuario desde una fecha en adelante
    @GetMapping("/sesiones")
    public List<SesionViewDTO> porUsuarioDesdefecha(
            @RequestParam Long idUsuario,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fecha) {
        return sesionService.porUsuarioDesdefecha(idUsuario, fecha);
    }
}
