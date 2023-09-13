with Gtk.Arguments;
with Gtk.Widget; use Gtk.Widget;

package Ventana_Conversor_Pkg.Callbacks is

   procedure Convertir_Hex_Dec
     (Object : access Gtk_Entry_Record'Class);

   procedure Convertir_Hex_Dec
     (Object : access Gtk_Button_Record'Class);

   procedure Imprimir_Hex
     (Object : access Gtk_Button_Record'Class);

   function Gtk_Main_Quit
     (Object : access Gtk_Widget_Record'Class;
      Params : Gtk.Arguments.Gtk_Args) return Boolean;

end Ventana_Conversor_Pkg.Callbacks;
