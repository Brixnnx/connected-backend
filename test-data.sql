-- Test Data SQL Script for MolinaChirinosTP
-- This script populates all tables with realistic test data
-- Password for all test users: Password123

-- Clear existing data (except roles which are seeded by application)
DELETE FROM reaccion;
DELETE FROM comentario;
DELETE FROM publicacion;
DELETE FROM mensaje;
DELETE FROM conexion;
DELETE FROM puntuacion;
DELETE FROM sesion_mentoria;
DELETE FROM resena_mentor;
DELETE FROM mentor;
DELETE FROM oportunidad;
DELETE FROM usuario_roles;
DELETE FROM usuario WHERE id_usuario > 1;

-- Insert test usuarios with different roles
-- Password for all users: "Password123" (BCrypt encoded with strength 10)
INSERT INTO usuario (primer_nombre, primer_apellido, email, password, pais, ciudad, fecha_nacimiento, descripcion, foto_perfil) VALUES
('Admin', 'Sistema', 'admin@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Peru', 'Lima', '1990-01-01', 'Administrador del sistema', 'https://i.pravatar.cc/150?img=1'),
('Juan', 'Pérez', 'juan.perez@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Peru', 'Lima', '1995-03-15', 'Desarrollador Full Stack apasionado por la tecnología', 'https://i.pravatar.cc/150?img=2'),
('María', 'González', 'maria.gonzalez@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Peru', 'Arequipa', '1993-07-20', 'Mentora en Data Science con 5 años de experiencia', 'https://i.pravatar.cc/150?img=3'),
('Carlos', 'Rodríguez', 'carlos.rodriguez@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Peru', 'Cusco', '1997-11-08', 'Estudiante de Ingeniería de Software', 'https://i.pravatar.cc/150?img=4'),
('Ana', 'Martínez', 'ana.martinez@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Peru', 'Lima', '1996-05-12', 'UX/UI Designer con pasión por crear experiencias increíbles', 'https://i.pravatar.cc/150?img=5'),
('Pedro', 'López', 'pedro.lopez@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Peru', 'Trujillo', '1994-09-25', 'Mentor en DevOps y Cloud Computing', 'https://i.pravatar.cc/150?img=6'),
('Laura', 'Sánchez', 'laura.sanchez@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Peru', 'Lima', '1998-02-14', 'Desarrolladora Frontend especializada en React', 'https://i.pravatar.cc/150?img=7'),
('Miguel', 'Torres', 'miguel.torres@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Peru', 'Piura', '1992-12-30', 'Mentor en Seguridad Informática', 'https://i.pravatar.cc/150?img=8');

-- Assign roles to users
-- admin@test.com -> ROLE_ADMIN
-- maria.gonzalez@test.com -> ROLE_MENTOR
-- pedro.lopez@test.com -> ROLE_MENTOR
-- miguel.torres@test.com -> ROLE_MENTOR
-- Others -> ROLE_USER

INSERT INTO usuario_roles (usuario_id, role_id)
SELECT u.id_usuario, r.id_role FROM usuario u, role r
WHERE u.email = 'admin@test.com' AND r.name = 'ROLE_ADMIN';

INSERT INTO usuario_roles (usuario_id, role_id)
SELECT u.id_usuario, r.id_role FROM usuario u, role r
WHERE u.email = 'maria.gonzalez@test.com' AND r.name = 'ROLE_MENTOR';

INSERT INTO usuario_roles (usuario_id, role_id)
SELECT u.id_usuario, r.id_role FROM usuario u, role r
WHERE u.email = 'pedro.lopez@test.com' AND r.name = 'ROLE_MENTOR';

INSERT INTO usuario_roles (usuario_id, role_id)
SELECT u.id_usuario, r.id_role FROM usuario u, role r
WHERE u.email = 'miguel.torres@test.com' AND r.name = 'ROLE_MENTOR';

INSERT INTO usuario_roles (usuario_id, role_id)
SELECT u.id_usuario, r.id_role FROM usuario u, role r
WHERE u.email = 'juan.perez@test.com' AND r.name = 'ROLE_USER';

INSERT INTO usuario_roles (usuario_id, role_id)
SELECT u.id_usuario, r.id_role FROM usuario u, role r
WHERE u.email = 'carlos.rodriguez@test.com' AND r.name = 'ROLE_USER';

INSERT INTO usuario_roles (usuario_id, role_id)
SELECT u.id_usuario, r.id_role FROM usuario u, role r
WHERE u.email = 'ana.martinez@test.com' AND r.name = 'ROLE_USER';

INSERT INTO usuario_roles (usuario_id, role_id)
SELECT u.id_usuario, r.id_role FROM usuario u, role r
WHERE u.email = 'laura.sanchez@test.com' AND r.name = 'ROLE_USER';

-- Insert conexiones (connections between users)
INSERT INTO conexion (id_solicitante, id_receptor, estado, fecha_solicitud, fecha_respuesta)
SELECT
    (SELECT id_usuario FROM usuario WHERE email = 'juan.perez@test.com'),
    (SELECT id_usuario FROM usuario WHERE email = 'maria.gonzalez@test.com'),
    'ACEPTADA',
    CURRENT_TIMESTAMP - INTERVAL '10 days',
    CURRENT_TIMESTAMP - INTERVAL '9 days';

INSERT INTO conexion (id_solicitante, id_receptor, estado, fecha_solicitud, fecha_respuesta)
SELECT
    (SELECT id_usuario FROM usuario WHERE email = 'juan.perez@test.com'),
    (SELECT id_usuario FROM usuario WHERE email = 'carlos.rodriguez@test.com'),
    'ACEPTADA',
    CURRENT_TIMESTAMP - INTERVAL '8 days',
    CURRENT_TIMESTAMP - INTERVAL '7 days';

INSERT INTO conexion (id_solicitante, id_receptor, estado, fecha_solicitud, fecha_respuesta)
SELECT
    (SELECT id_usuario FROM usuario WHERE email = 'ana.martinez@test.com'),
    (SELECT id_usuario FROM usuario WHERE email = 'laura.sanchez@test.com'),
    'ACEPTADA',
    CURRENT_TIMESTAMP - INTERVAL '5 days',
    CURRENT_TIMESTAMP - INTERVAL '4 days';

INSERT INTO conexion (id_solicitante, id_receptor, estado, fecha_solicitud)
SELECT
    (SELECT id_usuario FROM usuario WHERE email = 'carlos.rodriguez@test.com'),
    (SELECT id_usuario FROM usuario WHERE email = 'pedro.lopez@test.com'),
    'PENDIENTE',
    CURRENT_TIMESTAMP - INTERVAL '2 days';

INSERT INTO conexion (id_solicitante, id_receptor, estado, fecha_solicitud, fecha_respuesta)
SELECT
    (SELECT id_usuario FROM usuario WHERE email = 'laura.sanchez@test.com'),
    (SELECT id_usuario FROM usuario WHERE email = 'miguel.torres@test.com'),
    'RECHAZADA',
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days';

-- Insert mensajes (chat messages)
INSERT INTO mensaje (id_emisor, id_receptor, contenido, fecha_envio, leido)
SELECT
    (SELECT id_usuario FROM usuario WHERE email = 'juan.perez@test.com'),
    (SELECT id_usuario FROM usuario WHERE email = 'maria.gonzalez@test.com'),
    'Hola María! Me interesa tu mentoría en Data Science',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    true;

INSERT INTO mensaje (id_emisor, id_receptor, contenido, fecha_envio, leido)
SELECT
    (SELECT id_usuario FROM usuario WHERE email = 'maria.gonzalez@test.com'),
    (SELECT id_usuario FROM usuario WHERE email = 'juan.perez@test.com'),
    'Hola Juan! Claro, estaré encantada de ayudarte. ¿Qué temas te interesan?',
    CURRENT_TIMESTAMP - INTERVAL '1 hour 50 minutes',
    true;

INSERT INTO mensaje (id_emisor, id_receptor, contenido, fecha_envio, leido)
SELECT
    (SELECT id_usuario FROM usuario WHERE email = 'juan.perez@test.com'),
    (SELECT id_usuario FROM usuario WHERE email = 'maria.gonzalez@test.com'),
    'Me gustaría aprender sobre Machine Learning y análisis de datos',
    CURRENT_TIMESTAMP - INTERVAL '1 hour 30 minutes',
    false;

INSERT INTO mensaje (id_emisor, id_receptor, contenido, fecha_envio, leido)
SELECT
    (SELECT id_usuario FROM usuario WHERE email = 'carlos.rodriguez@test.com'),
    (SELECT id_usuario FROM usuario WHERE email = 'juan.perez@test.com'),
    '¿Viste la nueva oportunidad de pasantía en Google?',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    false;

-- Insert publicaciones (feed posts)
INSERT INTO publicacion (id_autor, contenido, imagen, fecha_publicacion)
SELECT
    (SELECT id_usuario FROM usuario WHERE email = 'juan.perez@test.com'),
    '¡Acabo de terminar mi primer proyecto en React! Estoy muy emocionado de compartirlo con ustedes. #WebDevelopment #React',
    'https://images.unsplash.com/photo-1633356122544-f134324a6cee?w=500',
    CURRENT_TIMESTAMP - INTERVAL '5 hours';

INSERT INTO publicacion (id_autor, contenido, fecha_publicacion)
SELECT
    (SELECT id_usuario FROM usuario WHERE email = 'maria.gonzalez@test.com'),
    'Nuevas tendencias en Data Science para 2025: AutoML, Explainable AI y Edge Computing. ¿Qué opinan? #DataScience #AI',
    CURRENT_TIMESTAMP - INTERVAL '3 hours';

INSERT INTO publicacion (id_autor, contenido, imagen, fecha_publicacion)
SELECT
    (SELECT id_usuario FROM usuario WHERE email = 'ana.martinez@test.com'),
    'Compartiendo mi último diseño de interfaz para una app de fitness. ¡Feedback bienvenido! #UX #UIDesign',
    'https://images.unsplash.com/photo-1586281380349-632531db7ed4?w=500',
    CURRENT_TIMESTAMP - INTERVAL '1 hour';

INSERT INTO publicacion (id_autor, contenido, fecha_publicacion)
SELECT
    (SELECT id_usuario FROM usuario WHERE email = 'pedro.lopez@test.com'),
    'Tutorial: Cómo desplegar tu aplicación en Kubernetes. Link en mi perfil. #DevOps #Kubernetes #CloudComputing',
    CURRENT_TIMESTAMP - INTERVAL '6 hours';

-- Insert comentarios (comments on publications)
INSERT INTO comentario (id_publicacion, id_autor, contenido, fecha_comentario)
SELECT
    (SELECT p.id_publicacion FROM publicacion p
     JOIN usuario u ON p.id_autor = u.id_usuario
     WHERE u.email = 'juan.perez@test.com' LIMIT 1),
    (SELECT id_usuario FROM usuario WHERE email = 'maria.gonzalez@test.com'),
    '¡Felicitaciones Juan! Se ve muy bien tu proyecto',
    CURRENT_TIMESTAMP - INTERVAL '4 hours 30 minutes';

INSERT INTO comentario (id_publicacion, id_autor, contenido, fecha_comentario)
SELECT
    (SELECT p.id_publicacion FROM publicacion p
     JOIN usuario u ON p.id_autor = u.id_usuario
     WHERE u.email = 'maria.gonzalez@test.com' LIMIT 1),
    (SELECT id_usuario FROM usuario WHERE email = 'carlos.rodriguez@test.com'),
    'Muy interesante María! El Explainable AI es el futuro',
    CURRENT_TIMESTAMP - INTERVAL '2 hours 45 minutes';

INSERT INTO comentario (id_publicacion, id_autor, contenido, fecha_comentario)
SELECT
    (SELECT p.id_publicacion FROM publicacion p
     JOIN usuario u ON p.id_autor = u.id_usuario
     WHERE u.email = 'ana.martinez@test.com' LIMIT 1),
    (SELECT id_usuario FROM usuario WHERE email = 'laura.sanchez@test.com'),
    'Me encanta la paleta de colores! 🎨',
    CURRENT_TIMESTAMP - INTERVAL '45 minutes';

-- Insert reacciones (reactions to publications)
INSERT INTO reaccion (id_publicacion, id_usuario, tipo, fecha_reaccion)
SELECT
    (SELECT p.id_publicacion FROM publicacion p
     JOIN usuario u ON p.id_autor = u.id_usuario
     WHERE u.email = 'juan.perez@test.com' LIMIT 1),
    (SELECT id_usuario FROM usuario WHERE email = 'maria.gonzalez@test.com'),
    'ME_GUSTA',
    CURRENT_TIMESTAMP - INTERVAL '4 hours 45 minutes';

INSERT INTO reaccion (id_publicacion, id_usuario, tipo, fecha_reaccion)
SELECT
    (SELECT p.id_publicacion FROM publicacion p
     JOIN usuario u ON p.id_autor = u.id_usuario
     WHERE u.email = 'juan.perez@test.com' LIMIT 1),
    (SELECT id_usuario FROM usuario WHERE email = 'carlos.rodriguez@test.com'),
    'ME_GUSTA',
    CURRENT_TIMESTAMP - INTERVAL '4 hours 15 minutes';

INSERT INTO reaccion (id_publicacion, id_usuario, tipo, fecha_reaccion)
SELECT
    (SELECT p.id_publicacion FROM publicacion p
     JOIN usuario u ON p.id_autor = u.id_usuario
     WHERE u.email = 'maria.gonzalez@test.com' LIMIT 1),
    (SELECT id_usuario FROM usuario WHERE email = 'juan.perez@test.com'),
    'ME_GUSTA',
    CURRENT_TIMESTAMP - INTERVAL '2 hours 50 minutes';

INSERT INTO reaccion (id_publicacion, id_usuario, tipo, fecha_reaccion)
SELECT
    (SELECT p.id_publicacion FROM publicacion p
     JOIN usuario u ON p.id_autor = u.id_usuario
     WHERE u.email = 'ana.martinez@test.com' LIMIT 1),
    (SELECT id_usuario FROM usuario WHERE email = 'juan.perez@test.com'),
    'ME_GUSTA',
    CURRENT_TIMESTAMP - INTERVAL '50 minutes';

-- Insert oportunidades (opportunities: jobs, internships, workshops, events)
INSERT INTO oportunidad (tipo, titulo, descripcion, empresa, fecha_inicio, activo) VALUES
('EMPLEO', 'Desarrollador Full Stack Senior', 'Buscamos desarrollador con experiencia en Spring Boot y React. Trabajo remoto.', 'Tech Solutions SAC', '2025-02-01', true),
('EMPLEO', 'Data Scientist', 'Únete a nuestro equipo de Data Science. Experiencia en Python y ML requerida.', 'Data Corp Peru', '2025-02-15', true),
('PASANTIA', 'Pasantía en Desarrollo Frontend', 'Pasantía de 6 meses para estudiantes de últimos ciclos. React y TypeScript.', 'StartupPE', '2025-03-01', true),
('PASANTIA', 'Internship DevOps', 'Aprende sobre CI/CD, Docker y Kubernetes en un entorno real.', 'CloudTech', '2025-03-15', true),
('TALLER', 'Workshop: Introducción a Machine Learning', 'Taller práctico de 3 días sobre fundamentos de ML con Python.', 'AI Academy', '2025-02-10', true),
('TALLER', 'Taller de UI/UX Design Thinking', 'Aprende metodologías de diseño centrado en el usuario.', 'Design School', '2025-02-20', true),
('EVENTO', 'Lima Tech Summit 2025', 'El evento más grande de tecnología en Perú. Speakers internacionales.', 'Tech Events Peru', '2025-04-15', true),
('EVENTO', 'Hackathon Nacional de IA', 'Competencia de 48 horas para resolver problemas con Inteligencia Artificial.', 'AI Peru', '2025-03-20', true);

-- Insert puntuaciones (gamification points)
INSERT INTO puntuacion (id_usuario, puntos_publicaciones, puntos_conexiones, puntos_mentorias, puntos_comentarios)
SELECT id_usuario, 10, 15, 0, 5 FROM usuario WHERE email = 'juan.perez@test.com';

INSERT INTO puntuacion (id_usuario, puntos_publicaciones, puntos_conexiones, puntos_mentorias, puntos_comentarios)
SELECT id_usuario, 10, 10, 50, 10 FROM usuario WHERE email = 'maria.gonzalez@test.com';

INSERT INTO puntuacion (id_usuario, puntos_publicaciones, puntos_conexiones, puntos_mentorias, puntos_comentarios)
SELECT id_usuario, 0, 10, 0, 5 FROM usuario WHERE email = 'carlos.rodriguez@test.com';

INSERT INTO puntuacion (id_usuario, puntos_publicaciones, puntos_conexiones, puntos_mentorias, puntos_comentarios)
SELECT id_usuario, 10, 10, 0, 0 FROM usuario WHERE email = 'ana.martinez@test.com';

INSERT INTO puntuacion (id_usuario, puntos_publicaciones, puntos_conexiones, puntos_mentorias, puntos_comentarios)
SELECT id_usuario, 0, 0, 0, 5 FROM usuario WHERE email = 'laura.sanchez@test.com';

INSERT INTO puntuacion (id_usuario, puntos_publicaciones, puntos_conexiones, puntos_mentorias, puntos_comentarios)
SELECT id_usuario, 10, 5, 40, 0 FROM usuario WHERE email = 'pedro.lopez@test.com';

INSERT INTO puntuacion (id_usuario, puntos_publicaciones, puntos_conexiones, puntos_mentorias, puntos_comentarios)
SELECT id_usuario, 0, 5, 30, 0 FROM usuario WHERE email = 'miguel.torres@test.com';

-- Insert mentores (mentor profiles)
INSERT INTO mentor (id_usuario, areas_experiencia, anos_experiencia, tarifa_hora, disponible)
SELECT id_usuario, 'Data Science, Machine Learning, Python', 5, 50.00, true
FROM usuario WHERE email = 'maria.gonzalez@test.com';

INSERT INTO mentor (id_usuario, areas_experiencia, anos_experiencia, tarifa_hora, disponible)
SELECT id_usuario, 'DevOps, Kubernetes, AWS, CI/CD', 6, 60.00, true
FROM usuario WHERE email = 'pedro.lopez@test.com';

INSERT INTO mentor (id_usuario, areas_experiencia, anos_experiencia, tarifa_hora, disponible)
SELECT id_usuario, 'Seguridad Informática, Ethical Hacking, Pentesting', 8, 75.00, true
FROM usuario WHERE email = 'miguel.torres@test.com';

-- Insert sesiones de mentoría
INSERT INTO sesion_mentoria (id_mentor, id_mentee, fecha_inicio, fecha_fin, estado, tema)
SELECT
    m.id_mentor,
    (SELECT id_usuario FROM usuario WHERE email = 'juan.perez@test.com'),
    CURRENT_TIMESTAMP + INTERVAL '3 days',
    CURRENT_TIMESTAMP + INTERVAL '3 days 1 hour',
    'AGENDADA',
    'Introducción a Machine Learning'
FROM mentor m
JOIN usuario u ON m.id_usuario = u.id_usuario
WHERE u.email = 'maria.gonzalez@test.com';

INSERT INTO sesion_mentoria (id_mentor, id_mentee, fecha_inicio, fecha_fin, estado, tema, notas)
SELECT
    m.id_mentor,
    (SELECT id_usuario FROM usuario WHERE email = 'carlos.rodriguez@test.com'),
    CURRENT_TIMESTAMP - INTERVAL '5 days',
    CURRENT_TIMESTAMP - INTERVAL '5 days' + INTERVAL '1 hour',
    'COMPLETADA',
    'Despliegue en Kubernetes',
    'Excelente sesión. Carlos aprendió los conceptos básicos de K8s.'
FROM mentor m
JOIN usuario u ON m.id_usuario = u.id_usuario
WHERE u.email = 'pedro.lopez@test.com';

-- Insert reseñas de mentores
INSERT INTO resena_mentor (id_mentor, id_autor, puntuacion, comentario, fecha_resena)
SELECT
    m.id_mentor,
    (SELECT id_usuario FROM usuario WHERE email = 'carlos.rodriguez@test.com'),
    5,
    'Excelente mentor! Pedro explica muy bien los conceptos de DevOps y es muy paciente.',
    CURRENT_TIMESTAMP - INTERVAL '4 days'
FROM mentor m
JOIN usuario u ON m.id_usuario = u.id_usuario
WHERE u.email = 'pedro.lopez@test.com';

INSERT INTO resena_mentor (id_mentor, id_autor, puntuacion, comentario, fecha_resena)
SELECT
    m.id_mentor,
    (SELECT id_usuario FROM usuario WHERE email = 'juan.perez@test.com'),
    5,
    'María es una mentora increíble. Me ayudó mucho a entender ML.',
    CURRENT_TIMESTAMP - INTERVAL '2 days'
FROM mentor m
JOIN usuario u ON m.id_usuario = u.id_usuario
WHERE u.email = 'maria.gonzalez@test.com';
