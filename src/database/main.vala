/* Copyright 2013, Sebastian Reichel <sre@ring0.de>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

public static void write_to_log(string message, ...) {
	/* TODO: send message via DBus? Replace some write_to_log by throwing an error? */
}

DataBase db;

public static int main(string[] args) {
	try {
		Config cfg = Bus.get_proxy_sync(BusType.SYSTEM, "io.mainframe.shopsystem.Config", "/io/mainframe/shopsystem/config");
		var dbfile = cfg.get_string("DATABASE", "file");
		db = new DataBase(dbfile);
	} catch(IOError e) {
		error("IOError: %s\n", e.message);
	} catch(KeyFileError e) {
		error("Config Error: %s\n", e.message);
	}

	Bus.own_name(
		BusType.SYSTEM,
		"io.mainframe.shopsystem.Database",
		BusNameOwnerFlags.NONE,
		on_bus_aquired,
		() => {},
		() => stderr.printf("Could not aquire name\n"));

	new MainLoop().run();

	return 0;
}

void on_bus_aquired(DBusConnection con) {
    try {
        con.register_object("/io/mainframe/shopsystem/database", db);
    } catch(IOError e) {
        stderr.printf("Could not register service\n");
    }
}
