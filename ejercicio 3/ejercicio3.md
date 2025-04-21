# Ejercicio 3: Concurrencia

- **Simular una situación donde dos usuarios intentan actualizar el mismo saldo de una cuenta bancaria. Analizar como afectan las condiciones de aislamiento (READ COMMITTED vs SERIALIZABLE).**


    El término transacción hace referencia a un conjunto de operaciones que forman una tarea única, como ser la transferencia de dinero de una cuenta a otra, que requiere de dos actualizaciones, una para cada cuenta. Esta situación es la que se conoce como concurrencia y si no se controlan las actualizaciones de los datos compartidos, existe la posibilidad de que las transacciones operen sobre estados intermedios inconsistentes.

	Realizando el ejercicio en Mysql Workbench, es claramente evidente que el definir condiciones de aislamiento afecta la ejecución de las transacciones, en general impidiéndolas. 

    Workbench no me permitió ejecutar dos  transacciones simultaneas “cuando las mismas tenían condiciones de aislamiento definidas”, pero no impidió que se ejecutasen cuando faltaba dicha definición. En este último caso, claramente resultaba confuso conocer el valor correcto del saldo en un momento dado.

