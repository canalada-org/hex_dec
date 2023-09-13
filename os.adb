--                              -*- Mode: Ada -*-
--  Filename        : os.adb
--  Description     : Funciones para hacer llamadas al sistema operativo de
--                      modo portable.
--  Author          : Gneuromante
--  Created On      : Mon Aug 28 00:32:14 2006
--  Last Modified By: .
--  Last Modified On: .
--  Update Count    : 0
--  Status          : Unknown, Use with caution!

with Gnat.Os_Lib; use Gnat.Os_Lib;
with Gnat.Directory_Operations;

with Ada.Text_Io; use Ada.Text_Io;
with Ada.Exceptions;

package body Os is

   --------------------------
   -- Que_Sistema_Operativo --
   --------------------------

   -- Creditos a Martin Dowie de comp.lang.ada
   --
   function Que_Sistema_Operativo return T_Os is
   begin
      if Existe_Env ("OS")
        and then Valor_Env ("OS") = "Windows_NT" then

         return Windows;

      elsif Existe_Env ("OSTYPE")
        and then Valor_Env ("OSTYPE") = "linux-gnu" then

         return Gnu_Linux;
      else

         return Desconocido;
      end if;
   end Que_Sistema_Operativo;

   function Existe_Env (Nombre : String) return Boolean
   is
      Valor     : String_Access := Getenv (Nombre);
      Resultado : Boolean;
   begin

      Resultado := Valor.all /= "";

      Free (Valor);

      return Resultado;

   end Existe_Env;

   function Valor_Env (Nombre : String) return String
   is
      Valor     : String_Access := Getenv (Nombre);
      Resultado : constant String := Valor.all;
   begin

      Free (Valor);

      return Resultado;

   end Valor_Env;

   procedure Imprimir (Texto : String) is

      Fichero        : File_Type;
      Exito          : Boolean;
      Print_Arg      : Gnat.Os_Lib.String_Access;
      Nombre_Fichero : Gnat.Os_Lib.String_Access :=
        new String'(Directorio_Temporales & Gnat.Directory_Operations.
                    Dir_Separator & "imprimir.tmp");
   begin

      Create (Fichero, Out_File, Nombre_Fichero.all);
      Put_Line (Fichero, Texto);
      Close (Fichero);

      case Que_Sistema_Operativo is
         when Windows =>

            Print_Arg := new String'("/p");

            -- Esto se podria hacer tambien importando "system", pero
            -- me gusta como suena spawn ;)
            Gnat.Os_Lib.Spawn (Program_Name => "notepad.exe",
                               Args         => (1 => Print_Arg,
                                                2 => Nombre_Fichero),
                               Success      => Exito);

         when Gnu_Linux | Desconocido =>

            Gnat.Os_Lib.Spawn (Program_Name => "/usr/bin/lpr",
                               Args         => (1 => Nombre_Fichero),
                               Success      => Exito);
      end case;

      if not Exito then
         Put_Line (Current_Error, "Error al intentar hacer ñapa para imprimir");
      end if;

      Gnat.Os_Lib.Free (Print_Arg);
      Gnat.Os_Lib.Free (Nombre_Fichero);

   exception
      when Ex : others =>
         Put_Line (Current_Error, "Excepcion en Imprimir: " &
                   Ada.Exceptions.Exception_Information (Ex));
        Gnat.Os_Lib.Free (Print_Arg);
        Gnat.Os_Lib.Free (Nombre_Fichero);

        raise;
   end Imprimir;

   function Directorio_Temporales return String
   is
   begin

      if Existe_Env ("TEMP") then

         return Valor_Env ("TEMP");

      elsif  Existe_Env ("TMP") then

         return Valor_Env ("TMP");

      else

         return "/tmp";
      end if;

   end Directorio_Temporales;

end Os;

