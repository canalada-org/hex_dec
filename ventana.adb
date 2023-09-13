with Gtk; use Gtk;
with Gtk; use Gtk;
with Gtk.Main;
with Gtk.Widget; use Gtk.Widget;
with Ventana_Conversor_Pkg; use Ventana_Conversor_Pkg;

package body Ventana is

   Ventana_Conversor : Ventana_Conversor_Access;

   procedure Inicializa is
   begin

      Gtk_New (Ventana_Conversor);
      Show_All (Ventana_Conversor);
   end Inicializa;

   function Ref return Ventana_Conversor_Access is
   begin
      return Ventana_Conversor;
   end Ref;

end Ventana;
