package Os is

   type T_Os is
     (Desconocido, Windows, Gnu_Linux);

   subtype T_Os_Conocido is T_Os range
     T_Os'Succ (Desconocido) .. T_Os'Last;

   -- Function: Que_Sistema_Operativo
   --
   -- Returns:
   --
   --    Sobre que sistema operativo se ejecuta el programa
   --
   function Que_Sistema_Operativo return T_Os;

   -- Function: Existe_Env
   --
   --    Si existe la variable de entorno de ese nombre
   --
   -- Parameters:
   --
   --    Nombre - Nombre de la variable de entorno
   --
   -- Returns:
   --
   --    Un boolean especificando si existe la variable
   --
   -- See Also:
   --      <Valor_Env>
   --
   function Existe_Env (Nombre : String) return Boolean;

   -- Function: Valor_Env
   --
   --   Valor de la variable de entorno. Si no existe la variable,
   --   devuelve "".
   --
   -- Parameters:
   --
   --    Nombre - Nombre de la variable de entorno
   --
   -- Returns:
   --
   --    El valor de la variable de entorno pasada
   --
   -- See Also:
   --      <Existe_Env>
   --
   function Valor_Env (Nombre : String) return String;


   -- Function: Directorio_Temporales
   --
   -- Returns:
   --
   --    Nombre del directorio en el que guardar archivos temporales en este S.O.
   --
   function Directorio_Temporales return String;

   -- Procedure: Imprimir
   --
   --   Imprime el texto pasado en el parámetro por la impresora por defecto.
   --
   -- Parameters:
   --
   --    Texto a imprimir. Puede albergar saltos de línea.
   --
   procedure Imprimir (Texto : String);

end Os;
