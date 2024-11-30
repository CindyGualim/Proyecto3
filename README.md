# Proyecto3
Este proyecto implementa un juego interactivo utilizando un controlador basado en ARM con soporte para la biblioteca WiringPi. El sistema emplea LEDs y botones para controlar la lógica del juego, en el que los jugadores alternan turnos con retroalimentación visual.

### Objetivo
Desarrollar un programa en Assembler que controle el encendido y apagado de LEDs en función de las entradas de botones y teclado. El juego registra el estado de los jugadores y sigue una secuencia predefinida de luces.

### *Funcionalidades*
Encendido Secuencial de LEDs:

Ocho LEDs se encienden en secuencia, con estados específicos según el progreso del juego.
Detección de Entradas:

Lectura de botones para avanzar en el estado del juego.

Lectura de teclado para iniciar o reiniciar el juego.

### *Control de Jugadores:*

- Alternancia entre dos jugadores.
- Indicadores visuales para mostrar el jugador activo.
- Mensajes de Estado: Visualización de mensajes de estado en consola, como "Introduce una tecla" y "Esperando un botón".
