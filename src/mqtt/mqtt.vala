/* Copyright 2018, Johannes Rudolph <johannes.rudolph@gmx.com>
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
using Posix;

[DBus (name = "io.mainframe.shopsystem.Mqtt")]
public class MQTTImplementation {

	private string mqttBroker;

	public MQTTImplementation(string broker) {
    		this.mqttBroker = broker;
	}

  	public void push_message(string message, string topic) {
		Posix.system("mosquitto_pub -h " + this.mqttBroker + " -t "+ topic +" -r -m '" + message.replace("'", "''") +"'");
  	}
}
