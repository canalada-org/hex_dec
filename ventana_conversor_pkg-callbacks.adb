with System; use System;
with Glib; use Glib;
with Glib.Convert; use Glib.Convert;

with Gdk.Event; use Gdk.Event;
with Gdk.Types; use Gdk.Types;
with Gtk.Accel_Group; use Gtk.Accel_Group;
with Gtk.Object; use Gtk.Object;
with Gtk.Enums; use Gtk.Enums;
with Gtk.Style; use Gtk.Style;
with Gtk.Widget; use Gtk.Widget;
with Gtk.Gentry; use Gtk.Gentry;
with Gtk.Main;

with Ventana_Conversor_Pkg; use Ventana_Conversor_Pkg;
with Ventana;
with Os;

with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Strings.Fixed; use Ada.Strings; use Ada.Strings.Fixed;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Exceptions;

with Gnat.Os_Lib;

package body Ventana_Conversor_Pkg.Callbacks is

   use Gtk.Arguments;

   function Hex_A_Dec (Hex : String) return String is
      Decimal : String (1 .. 100);
   begin
      Put (To   => Decimal,
           Item => Integer'Value ("16#" & Hex & "#"));
      return Trim (Side => Left, Source => Decimal);

   exception
      when Constraint_Error =>
         return "Error";
   end Hex_A_Dec;

   procedure Convertir_Hex_Dec
   is
     Ventana_Conversor : Ventana_Conversor_Access;
   begin

      Ventana_Conversor := Ventana.Ref;

      declare

         Hex : constant String := Locale_From_UTF8
           (Get_Text (Ventana_Conversor.Entry_Hex));

         Inicio  : Natural := Hex'First;
         Espacio : Natural := Hex'First;

         Dec : Unbounded_String := Null_Unbounded_String;
      begin

         while Inicio in Hex'range loop

            Espacio := Ada.Strings.Fixed.Index
              (Source => Hex (Inicio .. Hex'Last), Pattern => " ");

            if Espacio /= 0 then

               Dec := Dec & Hex_A_Dec (Hex (Inicio .. Espacio - 1)) & ' ';
               Inicio := Index_Non_Blank (Source => Hex (Espacio .. Hex'Last));

            else
               Dec := Dec & Hex_A_Dec (Hex (Inicio .. Hex'Last));
               Inicio := 0;
            end if;

         end loop;

         Set_Text (The_Entry => Ventana_Conversor.Entry_Dec,
                   Text      => Locale_To_UTF8 (To_String (Dec)));
      end;

   end Convertir_Hex_Dec;

   -----------------------
   -- Convertir_Hex_Dec --
   -----------------------

   procedure Convertir_Hex_Dec
     (Object : access Gtk_Button_Record'Class)
   is
   begin

      Convertir_Hex_Dec;
   end Convertir_Hex_Dec;


   -----------------------
   -- Convertir_Hex_Dec --
   -----------------------

   procedure Convertir_Hex_Dec
     (Object : access Gtk_Entry_Record'Class)
   is
   begin
      Convertir_Hex_Dec;
   end Convertir_Hex_Dec;
   ------------------
   -- Imprimir_Hex --
   ------------------

   procedure Imprimir_Hex
     (Object : access Gtk_Button_Record'Class)
   is
      Ventana_Conversor : Ventana_Conversor_Access := Ventana.Ref;
      Texto_Dec         : constant String          :=
        Locale_From_UTF8 (Get_Text (Ventana_Conversor.Entry_Dec));
      Texto_Hex         : constant String          :=
        Locale_From_UTF8 (Get_Text (Ventana_Conversor.Entry_Hex));
   begin

      Os.Imprimir ("Hexadecimal: " & Texto_Hex & ASCII.LF &
                   "Decimal:     " & Texto_Dec);

   exception
      when Ex : others =>
         Put_Line (Current_Error, "Excepcion en Imprimir_Hex: " &
                   Ada.Exceptions.Exception_Information (Ex));

   end Imprimir_Hex;

   -------------------
   -- Gtk_Main_Quit --
   -------------------

   function Gtk_Main_Quit
     (Object : access Gtk_Widget_Record'Class;
      Params : Gtk.Arguments.Gtk_Args) return Boolean
   is
      Arg1 : Gdk_Event := To_Event (Params, 1);
   begin
      Gtk.Main.Main_Quit;
      return False;
   end Gtk_Main_Quit;

end Ventana_Conversor_Pkg.Callbacks;
