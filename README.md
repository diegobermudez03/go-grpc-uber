repositorio: https://github.com/diegobermudez03/go-grpc-uber
video demostrativo: https://youtu.be/2NP7__F781E
# Uber gRPC

La presente carpeta contiene 3 componentes (uno mas que los solicitados):

- Servidor gRPC: es la carpeta server, al interior de la misma esta todo el codigo y ejecutables del servidor.
- Cliente gRPC: es el componente del cliente, por ende tambien es cliente en cuanto a gRPC, es un programa de terminal escrito en Go, al interior de la carpeta client
- Conductor uber gRPC: es el componente añadido, es el cliente conductor del UBER, es una aplicación movil desarrollada en flutter y compilada para android.

La razon por la que hay un componente de mas es porque el programa que se solicitaba era talvez algo basico, asi que quise meterle un poco de mas sabor con ese componente, es asi que la aplicacion tiene de mas lo siguiente:

- El servidor tiene registrados los Ubers solictados en el enunciado, los maneja como Bots, si no hay conductores reales conectados, trabajara con ellos (funcionamiento basico solicitado) dandole prioridad al de menor distancia de los bots. Pero si hay uno o mas conductores reales conectados, para hacer la cosa interesante, le dara prioridad a ellos antes que a los bots.

- El servidor envia la solicitud de carrera al uber, y notifica en todo tiempo al cliente de que esta haciendo (como Uber en la vida real), le va diciendo al cliente sobre que conductores esta consultando, quien rechazo, quien acepto.

- Los conductores pueden rechazar carreras, el servidor continua buscando entre conductores reales, si todos los reales rechazan, entonces esocge entre los bots.

- Los conductores pueden actualizar en todo momento su ubicacion en tiempo real.

Con las funcionalidades mencionadas anteriormente ahora el sistema es mucho mas interesante, incluyendo un alto componente de comunicacion en tiempo real (Streaming), todo por medio de gRPC.

## Compilación y ejecución

En la carpeta entregada ya estan los programas compilados para cada uno de los componentes, estos pueden ser encontrados y ejecutados de la siguiente forma:

- Servidor: en el path ./server/bin/ estan los compilados tanto para windows como para linux del componente, estos deben ser ejecutados como corresponde en cada SO.
- Cliente cliente: en el path ./client/bin/ estan los compilados para Windows y Linux igual que el caso del servidor
- Uber cliente: en el path ./taxi_app/apk/app-release.apk esta el .apk de la app movil para android.

En caso de querer realizar la compilación manualmente, se debe contar con lo siguiente:

- Servidor: Tener Go instalado en la maquina, y ejecutar el siguiente comando estando al interior de la carpeta "server" (es fundamental puesto que el compilador busca ahi las dependencias) go build -o <path-salida> ./cmd/main.go
- Cliente cliente: Es el mismo proceso que para el servidor, solo que dentro de la carpeta "client". go build -o <path-salida> ./cmd/main.go
- Uber cliente: Para compilar este componente se debe tener Flutter instalado en la maquina local, y luego de esto solo se debe ejecutar el siguiente comando dentro de la carpeta "taxi_app" flutter build apk. El apk resultante aparecera en ./build/app/outputs/flutter-apk/app-release.apk

Para los programas escritos en Go (server y cliente), se puede tambien usar el comando go run cmd/main.go. Este comando realiza JIT para ejecutar el programa sin necesidad de precompilacion.

## Consideraciones de ejecución

Para saber mas sobre las consideraciones y la explicacion del codigo, ver el video explicativo realizado en : https://youtu.be/2NP7__F781E

- El servidor siempre toma el puerto :9000, este puede modificarse dentro del archivo cmd/main.go.
- Los programas tanto de cliente como del uber preguntan al iniciar la direccion IP del servidor, si el servidor esta corriendo en la misma maquina que el cliente, entonces se puede omitir esto y los programas toman por defecto la direccion en maquina local. Para el caso del cliente Go toma 127.0.0.1:9000, pero para el caso de la app movil toma 10.0.2.2:9000, dado que se espera que si esta en maquina local este ejecutandose en el emulador de Android Studio, esa es la direccion usada para acceder al localhost.
- Si el servidor esta corriendo en una maquina distinta, se debe ingresar la direccion IP externa de dicha maquina, incluyendo el puerto :9000. Si no se tiene control sobre la configuracion de red donde esta el servidor entonces es mejor tener todos los componentes en la misma red local.

- IMPORTANTE: La simulacion solo llega hasta la parte de obtener un uber para la carrera, luego de eso el cliente puede volver al menu principal como si nada hubiera pasado. Y el uber seleccionado quedara en estado "ocupado" por todo el resto de la sesión del servidor. 