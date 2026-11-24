-- ==============================================================================
-- Schema & Seed Data for Superintendencia de Sociedades Conversational AI Bot
-- LegalTech & Regulatory Knowledge Base (Ley 1116 de 2006, SAS, Auxiliares)
-- ==============================================================================

CREATE TABLE IF NOT EXISTS greeting (
    id_greeting SERIAL PRIMARY KEY,
    initial_hour TIME,
    finish_hour TIME,
    description TEXT NOT NULL,
    type VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS information (
    id_information SERIAL PRIMARY KEY,
    type VARCHAR(100),
    action VARCHAR(100),
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS general (
    id_general SERIAL PRIMARY KEY,
    type VARCHAR(100),
    action VARCHAR(100),
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS procesos (
    id_proceso SERIAL PRIMARY KEY,
    type VARCHAR(100),
    action VARCHAR(100),
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS insolvencia (
    id_insolvencia SERIAL PRIMARY KEY,
    type VARCHAR(100),
    action VARCHAR(100),
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS sociedades (
    id SERIAL PRIMARY KEY,
    type VARCHAR(100),
    action VARCHAR(100),
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS consult (
    id_consult SERIAL PRIMARY KEY,
    type VARCHAR(100),
    action VARCHAR(100),
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS concepts (
    id_concept SERIAL PRIMARY KEY,
    type VARCHAR(100),
    action VARCHAR(100),
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS auxiliary_justice (
    id_auxiliary_justice SERIAL PRIMARY KEY,
    type VARCHAR(100),
    action VARCHAR(100),
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS extra_questions (
    id_question SERIAL PRIMARY KEY,
    question TEXT NOT NULL,
    answer TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS not_found_questions (
    id SERIAL PRIMARY KEY,
    question TEXT NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS history (
    id SERIAL PRIMARY KEY,
    id_chat VARCHAR(100),
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_chat (
    id_user SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS request (
    id SERIAL PRIMARY KEY,
    id_chat VARCHAR(100),
    id_user INTEGER,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================================================================
-- Seed Data: Saludos contextuados por horario
-- ==============================================================================
INSERT INTO greeting (initial_hour, finish_hour, description, type) VALUES
('05:00:00', '11:59:59', 'Buenos dias. Bienvenido al portal de atencion al ciudadano de la Superintendencia de Sociedades. En que puedo orientarle el dia de hoy?', 'Greeting_Morning'),
('12:00:00', '18:29:59', 'Buenas tardes. Bienvenido a la Superintendencia de Sociedades. Estoy aqui para brindarle informacion y orientacion sobre nuestros tramites y servicios.', 'Greeting_Afternoon'),
('18:30:00', '23:59:59', 'Buenas noches. Ha ingresado al asistente virtual de la Superintendencia de Sociedades. Recuerde que nuestros canales virtuales de radicacion operan las 24 horas.', 'Greeting_Night'),
(NULL, NULL, 'Hola, bienvenido al asistente virtual de la Superintendencia de Sociedades. En que puedo ayudarle?', 'Greeting_General');

-- ==============================================================================
-- Seed Data: Procesos de Reorganizacion e Insolvencia (Ley 1116 de 2006)
-- ==============================================================================
INSERT INTO procesos (type, action, description) VALUES
('Insolvencia', 'Reorganizacion', 'El proceso de reorganizacion empresarial (Ley 1116 de 2006) pretende preservar empresas viables y normalizar sus relaciones comerciales y crediticias mediante la celebracion de un acuerdo con sus acreedores.'),
('Insolvencia', 'Liquidacion', 'El proceso de liquidacion judicial persigue la pronta y ordenada liquidacion del patrimonio del deudor, mediante la enajenacion o adjudicacion de los bienes para el pago a los acreedores.'),
('Insolvencia', 'Requisitos', 'Para acogerse al regimen de insolvencia debe acreditar cesacion de pagos (2 o mas obligaciones vencidas a mas de 90 dias que representen no menos del 10% del pasivo total) o incapacidad de pago inminente.'),
('Insolvencia', 'Validacion', 'El proceso de validacion judicial permite convalidar ante la Superintendencia un acuerdo extrajudicial de reorganizacion alcanzado previamente entre la empresa y la mayoria de sus acreedores.'),
('Proceso', 'Intervencion', 'Las medidas de intervencion judicial por captacion masiva y habitual de dinero no autorizada se rigen por el Decreto 4334 de 2008.');

INSERT INTO insolvencia (type, action, description) VALUES
('Insolvencia', 'General', 'El regimen de insolvencia de la Ley 1116 de 2006 busca la proteccion del credito, la recuperacion y conservacion de la empresa como unidad de explotacion economica y fuente generadora de empleo.'),
('Insolvencia', 'Promotor', 'El promotor de insolvencia tiene como funcion principal participar en la negociacion y confeccion del acuerdo de reorganizacion empresarial entre el deudor y sus acreedores.');

-- ==============================================================================
-- Seed Data: Sociedades Comerciales (SAS, S.A., Ltda.)
-- ==============================================================================
INSERT INTO sociedades (type, action, description) VALUES
('Sociedades', 'SAS', 'La Sociedad por Acciones Simplificada (SAS), creada por la Ley 1258 de 2008, puede constituirse por una o varias personas naturales o juridicas mediante documento privado inscrito en el Registro Mercantil.'),
('Sociedades', 'Constitucion', 'Las sociedades mercantiles se constituyen habitualmente por escritura publica o documento privado (en el caso de SAS), inscribiendose en la Camara de Comercio correspondiente a su domicilio.'),
('Sociedades', 'Capital', 'En la SAS, el capital se divide en capital autorizado, suscrito y pagado. El pago del capital suscrito puede pactarse hasta en un plazo maximo de 2 anos.'),
('Sociedades', 'Disolucion', 'Las causales de disolucion son aquellas previstas en la ley o estatutos, entre ellas pérdidas que reduzcan el patrimonio neto por debajo del 50% del capital suscrito (conforme a la legislacion comercial colombiana).'),
('Sociedades', 'Reformas', 'Cualquier modificacion a los estatutos sociales (aumento de capital, cambio de objeto, domicilio o razon social) debe ser aprobada por el organo competente e inscrita ante la Camara de Comercio.');

-- ==============================================================================
-- Seed Data: Auxiliares de la Justicia (Promotores, Liquidadores, Peritos)
-- ==============================================================================
INSERT INTO auxiliary_justice (type, action, description) VALUES
('Auxiliares', 'Inscripcion', 'Para inscribirse como Auxiliar de la Justicia (Promotor, Liquidador o Perito) debe participar en la convocatoria publica anual dispuesta por la Superintendencia y acreditar idoneidad profesional y experiencia.'),
('Auxiliares', 'Requisitos', 'Los aspirantes a liquidadores y promotores deben acreditar titulo profesional universitario en Derecho, Economia, Administracion o Contaduria, con especializacion afin y experiencia comprobada.'),
('Auxiliares', 'Inhabilidades', 'No podran ser designados quienes tengan vinculos de parentesco hasta el cuarto grado de consanguinidad o segundo de afinidad con el deudor, administradores o acreedores mayoritarios.'),
('Auxiliares', 'Honorarios', 'Los honorarios de los auxiliares de la justicia son fijados por el juez del concurso (la Superintendencia de Sociedades) de acuerdo con los parametros reglamentarios y la complejidad del proceso.');

-- ==============================================================================
-- Seed Data: Conceptos Doctrinales y Juridicos
-- ==============================================================================
INSERT INTO concepts (type, action, description) VALUES
('Conceptos', 'Administradores', 'De acuerdo con el articulo 200 del Codigo de Comercio y la Ley 222 de 1995, los administradores responden solidaria e ilimitadamente de los perjuicios que por dolo o culpa ocasionen a la sociedad, socios o terceros.'),
('Conceptos', 'Dividendos', 'El reparto de dividendos debe ser aprobado por la asamblea general de accionistas con base en estados financieros fidedignos de fin de ejercicio, previa deduccion de reservas legales y estatutarias.'),
('Conceptos', 'Conflictos', 'En caso de conflicto de intereses entre un administrador y la sociedad, este debera abstenerse de participar en la decision y someter la autorizacion a la asamblea general de socios.'),
('Conceptos', 'Supervision', 'La Superintendencia de Sociedades ejerce inspeccion, vigilancia y control sobre las sociedades comerciales, conforme a los articulos 83, 84 y 85 de la Ley 222 de 1995.');

-- ==============================================================================
-- Seed Data: Informacion Institucional y Consultas
-- ==============================================================================
INSERT INTO information (type, action, description) VALUES
('Information', 'Sede', 'La sede principal de la Superintendencia de Sociedades se encuentra en la Avenida El Dorado No. 51-80, Bogota D.C., Colombia. Tambien cuenta con intendencias regionales en Medellin, Cali, Barranquilla, Bucaramanga, Manizales y Cartagena.'),
('Information', 'Horarios', 'El horario de atencion al publico presencial y ventanilla de radicacion es de lunes a viernes de 8:00 a.m. a 5:00 p.m. jornada continua.'),
('Information', 'Canales', 'Usted puede radicar tramites a traves del portal web oficial (www.supersociedades.gov.co), correo electronico institucional o en nuestras sedes fisicas.');

INSERT INTO general (type, action, description) VALUES
('General', 'Funciones', 'La Superintendencia de Sociedades es un organismo tecnico adscrito al Ministerio de Comercio, Industria y Turismo, que ejerce la inspeccion, vigilancia y control de las sociedades mercantiles en Colombia.');

INSERT INTO consult (type, action, description) VALUES
('Consult', 'Radicado', 'Para consultar el estado de un radicado mercantil o judicial, ingrese al modulo de Consulta de Tramites en www.supersociedades.gov.co e ingrese el numero de radicado de 10 digitos.');

-- ==============================================================================
-- Seed Data: Preguntas Frecuentes Estaticas (Extra Questions)
-- ==============================================================================
INSERT INTO extra_questions (question, answer) VALUES
('que es una sas', 'Una Sociedad por Acciones Simplificada (SAS) es un tipo societario regulado por la Ley 1258 de 2008, que ofrece flexibilidad contractual, responsabilidad limitada al monto de aportes y simplificacion en sus tramites de constitucion.'),
('como radico un derecho de peticion', 'Puede radicar un derecho de peticion a traves del sistema de PQRSD en la sede electronica de la Superintendencia de Sociedades o enviandolo al correo webmaster@supersociedades.gov.co.'),
('que es un acuerdo de reorganizacion', 'Es un convenio celebrado entre el deudor y sus acreedores con el fin de reestructurar los pasivos y permitir la continuidad operativa y preservacion del empleo en la empresa.');
