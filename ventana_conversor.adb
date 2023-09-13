with Gtk; use Gtk;
with Gtk; use Gtk;
with Gtk.Main;
with Gtk.Widget; use Gtk.Widget;
with Ventana;

procedure Ventana_Conversor is
begin
   Gtk.Main.Set_Locale;
   Gtk.Main.Init;
   Ventana.Inicializa;
   Gtk.Main.Main;
end Ventana_Conversor;
