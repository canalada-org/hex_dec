with Gtk.Handlers;
pragma Elaborate_All (Gtk.Handlers);
with Gtk.GEntry; use Gtk.GEntry;
with Gtk.Button; use Gtk.Button;

package Callbacks_Hex_Dec is

   package Entry_Callback is new
     Gtk.Handlers.Callback (Gtk_Entry_Record);

   package Button_Callback is new
     Gtk.Handlers.Callback (Gtk_Button_Record);

end Callbacks_Hex_Dec;
