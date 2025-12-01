package com.upc.molinachirinostp.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record RegistrarMentorDTO(
        @NotNull Long usuarioId,
        String bio,
        String areasExperiencia,
        @Positive Integer anosExperiencia,
        @Positive Double tarifaHora,
        Boolean disponible
) {}
