//Universidad del Valle de Guatemala
//Organización de computadoras y Assembler 
//Cindy Mishelle Gualim Pérez 21226
.data
.balign 4

    mensajeerror: .asciz "Error en la ejecucion"
    mensajetecla: .asciz "Introduce una tecla"
    mensajeboton: .asciz "esperando un boton"
    mensajeSensor: .asciz "esperando un sensor"
    mensajeultimojugador: .asciz "Ultimo jugador: "

    tecla: .asciz "tecla"

    formato: .asciz "%s"

    ultimoJugador: .asciz " "
    primerJugador: .asciz "jugador 1"
    segundoJugador: .asciz "jugador 2"

    siguienteEstado: .int 1

.text
    .global main
    .extern wiringPiSetup
    .extern pinMode
    .extern digitalWrite
    .extern digitalRead
    .extern delay

main: push {ip, lr}
    bl wiringPiSetup
    mov r1, #-1
    cmp r0, r1
    bne inicio

    ldr r0, =mensajeerror
    bl printf
    b end

    inicio:
    bl myPinmodes // llama a la función que hace que se inicien los pines en su modo lectura / escritura.

    primeraLed:

        mov r0, #1500
        bl delay

        mov r0, #0 // inicializar pin como salida. 
        mov r1, #1
        bl pinMode

        mov r0, #0
        mov r1, #1
        bl digitalWrite

        ldr r0, =siguienteEstado
        mov r1, #2
        str r1, [r0]

        bl esperandoTecla

    segundaLed:
        mov r0, #1500
        bl delay
        
        mov r0, #1
        mov r1, #1
        bl digitalWrite

        ldr r0, =siguienteEstado
        mov r1, #3
        str r1, [r0]

        bl esperandoTecla

    terceraLed:
        mov r0, #1500
        bl delay

        // apagando leds
        mov r0, #0
        mov r1, #0
        bl digitalWrite

        mov r0, #1
        mov r1, #0
        bl digitalWrite

        // encendiendo led
        mov r0, #2
        mov r1, #1
        bl digitalWrite

        ldr r0, =siguienteEstado
        mov r1, #4
        str r1, [r0]

        bl esperandoTecla

    cuartaLed:
        mov r0, #1500
        bl delay

        mov r0, #3
        mov r1, #1
        bl digitalWrite

        ldr r0, =siguienteEstado
        mov r1, #5
        str r1, [r0]

        bl esperandoTecla

    quintaLed:
        mov r0, #1500
        bl delay
        
        mov r0, #2
        mov r1, #0
        bl digitalWrite

        mov r0, #3
        mov r1, #0
        bl digitalWrite

        // encendiendo led
        mov r0, #4
        mov r1, #1
        bl digitalWrite

        ldr r0, =siguienteEstado
        mov r1, #6
        str r1, [r0]

        bl esperandoTecla

    sextaLed:
        mov r0, #1500
        bl delay

        mov r0, #5
        mov r1, #1
        bl digitalWrite

        ldr r0, =siguienteEstado
        mov r1, #7
        str r1, [r0]

        bl esperandoTecla

    septimaLed:
        mov r0, #1500
        bl delay

        mov r0, #4
        mov r1, #0
        bl digitalWrite

        mov r0, #5
        mov r1, #0
        bl digitalWrite

        // encendiendo led
        mov r0, #6
        mov r1, #1
        bl digitalWrite

        ldr r0, =siguienteEstado
        mov r1, #8
        str r1, [r0]

        bl esperandoTecla

    octavaLed:
        mov r0, #1500
        bl delay
        
        mov r0, #7
        mov r1, #1
        bl digitalWrite

        ldr r0, =siguienteEstado
        mov r1, #1
        str r1, [r0]

        // final del juego. 

        ldr r0, =mensajetecla
        bl printf

        ldr r0, =formato
        ldr r1, =tecla
        bl scanf
        
        ldr r2, =tecla
        ldrb r2, [r2]
        cmp r2, #0x71
        beq inicio

        ldr r0, =mensajeSensor
        bl printf

        mov r0, #1000
        bl delay

        mov r0, #25	 		
        bl 	digitalRead
        cmp	r0, #0 // INVESTIGAR ESTO
        bne inicio

        mov r0, #2000
        bl delay
        b end


myPinmodes:
    // Inicializar los pines de salida
    mov r0, #0 // salidas
    mov r1, #1
    bl pinMode

    mov r0, #1
    mov r1, #1
    bl pinMode

    mov r0, #2
    mov r1, #1
    bl pinMode

    mov r0, #3
    mov r1, #1
    bl pinMode

    mov r0, #4
    mov r1, #1
    bl pinMode

    mov r0, #5
    mov r1, #1
    bl pinMode

    mov r0, #6
    mov r1, #1
    bl pinMode

    mov r0, #7
    mov r1, #1
    bl pinMode

    mov r0, #21 // entradas
    mov r1, #0
    bl pinMode

    mov r0, #25 
    mov r1, #0
    bl pinMode

    mov r0, #22 // salida jugador 1
    mov r1, #1
    bl pinMode

    mov r0, #23 // salida jugador 2
    mov r1, #1
    bl pinMode

    b esperandoTecla
    

esperandoTecla:
    ldr r0, =mensajetecla
    bl printf

    ldr r0, =formato
    ldr r1, =tecla
    bl scanf
    
    ldr r5, =tecla
    ldrb r5, [r5]

    cmp r5, #0x79
    beq print1

    b esperandoBoton

esperandoBoton:
    ldr r0, =mensajeboton
    bl printf

    mov r0, #21
    bl digitalRead

    cmp r0, #0
    bne print2:

    b esperandoTecla

print1:
    ldr r0, =mensajeultimojugador
    bl printf

    ldr r0, =jugador1
    bl printf

    mov r0, #23
    mov r1, #0
    bl digitalWrite

    mov r0, #22 // se prende la luz de jugador 1
    mov r1, #1
    bl digitalWrite

    b identificarEstado

print2:
    ldr r0, =mensajeultimojugador
    bl printf

    ldr r0, =jugador2
    bl printf

    mov r0, #23
    mov r1, #1
    bl digitalWrite

    mov r0, #22 // se prende la luz de jugador 2
    mov r1, #0
    bl digitalWrite

    b identificarEstado

identificarEstado:
    // identificar en que estado está el juego
    ldr r0, =siguienteEstado
    ldr r0, [r0]
    cmp r0, #1
    beq primeraLed
    ldr r0, =siguienteEstado
    ldr r0, [r0]
    cmp r0, #2
    beq segundaLed
    ldr r0, =siguienteEstado
    ldr r0, [r0]
    cmp r0, #3
    beq terceraLed
    ldr r0, =siguienteEstado
    ldr r0, [r0]
    cmp r0, #4
    beq cuartaLed
    ldr r0, =siguienteEstado
    ldr r0, [r0]
    cmp r0, #5
    beq quintaLed
    ldr r0, =siguienteEstado
    ldr r0, [r0]
    cmp r0, #6
    beq sextaLed
    ldr r0, =siguienteEstado
    ldr r0, [r0]
    cmp r0, #7
    beq septimaLed
    ldr r0, =siguienteEstado
    ldr r0, [r0]
    cmp r0, #8
    beq octavaLed

end:
    pop {ip, pc}

    
    



