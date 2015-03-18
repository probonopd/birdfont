/*
    Copyright (C) 2015 Johan Mattsson

    This library is free software; you can redistribute it and/or modify 
    it under the terms of the GNU Lesser General Public License as 
    published by the Free Software Foundation; either version 3 of the 
    License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful, but 
    WITHOUT ANY WARRANTY; without even the implied warranty of 
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
    Lesser General Public License for more details.
*/

using Bird;
using Cairo;

namespace BirdFont {

public class Theme : GLib.Object {

	static Gee.HashMap<string, Color> colors;
	public static Gee.ArrayList<string> color_list;
	public static Gee.ArrayList<string> themes;
	public static string current_theme;

	public static void text_color (Text text, string name) {
		Color c;
		
		if (unlikely (!colors.has_key (name))) {
			warning (@"Theme does not have a color for $name");
			return;
		}
		
		c = colors.get (name);
		text.set_source_rgba (c.r, c.g, c.b, c.a);
	}

	public static void color (Context cr, string name) {
		Color c;
		
		if (unlikely (!colors.has_key (name))) {
			warning (@"Theme does not have a color for $name");
			return;
		}
		
		c = colors.get (name);
		cr.set_source_rgba (c.r, c.g, c.b, c.a);
	}

	public static void color_opacity (Context cr, string name, double opacity) {
		Color c;
		
		if (unlikely (!colors.has_key (name))) {
			warning (@"Theme does not have a color for $name");
			return;
		}
		
		c = colors.get (name);
		cr.set_source_rgba (c.r, c.g, c.b, opacity);
	}

	public static void gradient (Cairo.Pattern p, string name1, string name2) {
		Color c1 = get_color (name1);
		Color c2 = get_color (name2);
		
		p.add_color_stop_rgba (1, c1.r, c1.g, c1.b, c1.a);
		p.add_color_stop_rgba (0, c2.r, c2.g, c2.b, c2.a);
	}

	public static void text_color_opacity (Text text, string name, double opacity) {
		Color c;
		
		if (unlikely (!colors.has_key (name))) {
			warning (@"Theme does not have a color for $name");
			return;
		}
		
		c = colors.get (name);
		text.set_source_rgba (c.r, c.g, c.b, opacity);
	}
	
	public static Color get_color (string name) {
		Color c;
		
		if (unlikely (!colors.has_key (name))) {
			warning (@"Theme does not have a color for $name");
			return new Color (0, 0, 0, 1);
		}
		
		return colors.get (name);
	}
		
	public static void set_default_colors () {
		current_theme = "default.theme";
		color_list = new Gee.ArrayList<string> ();
		colors = new Gee.HashMap<string, Color> ();
		themes = new Gee.ArrayList<string> ();

		add_theme_files ();
		
		Theme.set_default_color ("Stroke Color", 0, 0, 0, 1);
		Theme.set_default_color ("Handle Color", 0, 0, 0, 1);
		Theme.set_default_color ("Fill Color", 0.5, 0.5, 0.5, 1);
		
		Theme.set_default_color ("Background 1", 1, 1, 1, 1);
		Theme.set_default_color ("Background 2", 101 / 255.0, 108 / 255.0, 116 / 255.0, 1);
		Theme.set_default_color ("Background 3", 38 / 255.0, 39 / 255.0, 43 / 255.0, 1);
		Theme.set_default_color ("Background 4", 51 / 255.0, 54 / 255.0, 59 / 255.0, 1);
		Theme.set_default_color ("Background 5", 0.3, 0.3, 0.3, 1);
		Theme.set_default_color ("Background 6", 224/255.0, 224/255.0, 224/255.0, 1);
		Theme.set_default_color ("Background 7", 56 / 255.0, 59 / 255.0, 65 / 255.0, 1);
		Theme.set_default_color ("Background 8", 55/255.0, 55/255.0, 55/255.0, 1);
		Theme.set_default_color ("Background 9", 72/255.0, 72/255.0, 72/255.0, 1);
		Theme.set_default_color ("Background 10", 223/255.0, 223/255.0, 223/255.0, 1);
		
		Theme.set_default_color ("Foreground 1", 0, 0, 0, 1);
		Theme.set_default_color ("Foreground 2", 101 / 255.0, 108 / 255.0, 116 / 255.0, 1);
		Theme.set_default_color ("Foreground 3", 26 / 255.0, 30 / 255.0, 32 / 255.0, 1);
		Theme.set_default_color ("Foreground 4", 40 / 255.0, 57 / 255.0, 65 / 255.0, 1);
		Theme.set_default_color ("Foreground 5", 70 / 255.0, 77 / 255.0, 83 / 255.0, 1);
		Theme.set_default_color ("Foreground 6", 45 / 255.0, 45 / 255.0, 45 / 255.0, 1);
		Theme.set_default_color ("Foreground 7", 219 / 255.0, 221 / 255.0, 233 / 255.0, 1);
		
		Theme.set_default_color ("Foreground Inverted", 1, 1, 1, 1);
		Theme.set_default_color ("Menu Foreground", 101 / 255.0, 108 / 255.0, 116 / 255.0, 1);
		
		Theme.set_default_color ("Highlighted 1", 234 / 255.0, 77 / 255.0, 26 / 255.0, 1);
		
		Theme.set_default_color ("Highlighted Guide", 0, 0, 0.3, 1);
		Theme.set_default_color ("Guide 1", 0.7, 0.7, 0.8, 1);
		Theme.set_default_color ("Guide 2", 0.7, 0, 0, 0.5);
		Theme.set_default_color ("Guide 3", 120 / 255.0, 68 / 255.0, 120 / 255.0, 120 / 255.0);
		
		Theme.set_default_color ("Grid",0.2, 0.6, 0.2, 0.2);
		
		Theme.set_default_color ("Background Glyph", 0.2, 0.2, 0.2, 0.5);
		
		Theme.set_default_color ("Button Border 1", 38 / 255.0, 39 / 255.0, 43 / 255.0, 1);
		Theme.set_default_color ("Button Background 1", 14 / 255.0, 16 / 255.0, 17 / 255.0, 1);

		Theme.set_default_color ("Button Border 2", 38 / 255.0, 39 / 255.0, 43 / 255.0, 1);
		Theme.set_default_color ("Button Background 2", 26 / 255.0, 30 / 255.0, 32 / 255.0, 1);

		Theme.set_default_color ("Button Border 3", 38 / 255.0, 39 / 255.0, 43 / 255.0, 1);
		Theme.set_default_color ("Button Background 3", 44 / 255.0, 47 / 255.0, 51 / 255.0, 1);

		Theme.set_default_color ("Button Border 4", 38 / 255.0, 39 / 255.0, 43 / 255.0, 1);
		Theme.set_default_color ("Button Background 4", 33 / 255.0, 36 / 255.0, 39 / 255.0, 1);
		
		Theme.set_default_color ("Button Foreground", 1, 1, 1, 1);
		Theme.set_default_color ("Selected Button Foreground", 1, 1, 1, 1);

		Theme.set_default_color ("Tool Foreground", 101 / 255.0, 108 / 255.0, 116 / 255.0, 1);
		Theme.set_default_color ("Selected Tool Foreground", 101 / 255.0, 108 / 255.0, 116 / 255.0, 1);
		
		Theme.set_default_color ("Selected Tool Foreground", 101 / 255.0, 108 / 255.0, 116 / 255.0, 1);
		
		Theme.set_default_color ("Text Area Background", 101 / 255.0, 108 / 255.0, 116 / 255.0, 1);

		Theme.set_default_color ("Selected Overview Item 1", 208 / 255.0, 208 / 255.0, 208 / 255.0, 1);
		Theme.set_default_color ("Selected Overview Item 2", 229 / 255.0, 229 / 255.0, 229 / 255.0, 1);

		Theme.set_default_color ("Overview Item 1", 236 / 255.0, 236 / 255.0, 236 / 255.0, 1);
		Theme.set_default_color ("Overview Item 2", 246 / 255.0, 246 / 255.0, 246 / 255.0, 1);
		
		Theme.set_default_color ("Overview Selected Foreground", 45 / 255.0, 45 / 255.0, 45 / 255.0, 1);
		Theme.set_default_color ("Overview Foreground", 45 / 255.0, 45 / 255.0, 45 / 255.0, 1);
		
		Theme.set_default_color ("Glyph Count Background", 101 / 255.0, 108 / 255.0, 116 / 255.0, 1);
		
		Theme.set_default_color ("Dialog Shadow", 0, 0, 0, 0.3);
		
		Theme.set_default_color ("Selected Active Cubic Control Point", 0, 0, 0, 1);
		Theme.set_default_color ("Selected Cubic Control Point", 0, 0, 0, 1);
		Theme.set_default_color ("Active Cubic Control Point", 160 / 255.0, 160 / 255.0, 160 / 255.0, 1);
		Theme.set_default_color ("Cubic Control Point", 116 / 255.0, 116 / 255.0, 116 / 255.0, 1);

		Theme.set_default_color ("Selected Active Quadratic Control Point", 0, 0, 0, 1);
		Theme.set_default_color ("Selected Quadratic Control Point", 0, 0, 0, 1);
		Theme.set_default_color ("Active Quadratic Control Point", 131 / 255.0, 182 / 255.0, 255 / 255.0, 1);
		Theme.set_default_color ("Quadratic Control Point", 123 / 255.0, 151 / 255.0, 184 / 255.0, 1);

		Theme.set_default_color ("Selected Control Point Handle", 0, 0, 0, 1);
		Theme.set_default_color ("Active Control Point Handle", 80 / 255.0, 118 / 255.0, 64 / 255.0, 1);
		Theme.set_default_color ("Control Point Handle", 56 / 255.0, 62 / 255.0, 45 / 255.0, 1);

		if (BirdFont.has_argument ("--test")) {
			current_theme = "generated_theme.theme";
			write_theme ();
			
			t_("Stroke Color");
			t_("Handle Color");
			t_("Fill Color");
			
			t_("Background 1");
			t_("Background 2");
			t_("Background 3");
			t_("Background 4");
			t_("Background 5");
			t_("Background 6");
			t_("Background 7");
			t_("Background 8");
			t_("Background 9");
			
			t_("Foreground 1");
			t_("Foreground 2");
			t_("Foreground 3");
			t_("Foreground 4");
			t_("Foreground 5");
			t_("Foreground 6");
			t_("Foreground 7");
			t_("Foreground Inverted");
			t_("Menu Foreground");
			
			t_("Highlighted 1");
			t_("Highlighted Guide");
			
			t_("Grid");
			
			t_("Guide 1");
			t_("Guide 2");
			t_("Guide 3");
			
			t_("Button Border 1");
			t_("Button Background 1");
			t_("Button Border 2");
			t_("Button Background 2");
			t_("Button Border 3");
			t_("Button Background 3");
			t_("Button Border 4");
			t_("Button Background 4");
			
			t_("Button Foreground");
			t_("Selected Button Foreground");
			
			t_("Tool Foreground");
			t_("Selected Tool Foreground");
			
			t_("Text Area Background");
			
			t_("Selected Overview Item 1");
			t_("Selected Overview Item 2");

			t_("Overview Item 1");
			t_("Overview Item 2");
		
			t_("Overview Selected Foreground");
			t_("Overview Foreground");
			
			t_("Glyph Count Background");
			
			t_("Dialog Shadow");

			t_("Selected Active Cubic Control Point");
			t_("Selected Cubic Control Point");
			t_("Active Cubic Control Point");
			t_("Cubic Control Point");

			t_("Selected Active Quadratic Control Point");
			t_("Selected Quadratic Control Point");
			t_("Active Quadratic Control Point");
			t_("Cubic Quadratic Point");

			t_("Selected Control Point Handle");
			t_("Active Control Point Handle");
			t_("Control Point Handle");

		}
	}
	
	static void add_theme_files () {
		FileEnumerator enumerator;
		FileInfo? file_info;
		string file_name;
		File dir;
		
		dir = BirdFont.get_settings_directory ();

		themes.clear ();
		themes.add ("default.theme");
		themes.add ("high_contrast.theme");
		
		try {
			enumerator = dir.enumerate_children (FileAttribute.STANDARD_NAME, 0);
			while ((file_info = enumerator.next_file ()) != null) {
				file_name = ((!) file_info).get_name ();
				
				if (file_name.has_suffix (".theme")) {
					themes.add (file_name);
				}
			}
		} catch (Error e) {
			warning (e.message);
		}
	}
	
	public static void set_default_color (string name, double r, double g, double b, double a) {
		color_list.add (name);
		colors.set (name, new Color (r, g, b, a));
	}
	
	public static void save_color (string name, double r, double g, double b, double a) {
		colors.set (name, new Color (r, g, b, a));
		write_theme ();
	}

	public static void load_theme (string theme_file) {
		File default_theme;
		File user_theme;

		user_theme = get_child (BirdFont.get_settings_directory (), theme_file);
		if (user_theme.query_exists ()) {
			current_theme = theme_file;
			parse_theme (user_theme);
			return;
		}
		
		default_theme = SearchPaths.find_file (null, theme_file);
		if (default_theme.query_exists ()) {
			current_theme = theme_file;
			parse_theme (default_theme);
			return;
		}
		
		warning (@"Theme not found: $theme_file");
	}

	public static void write_theme () {
		DataOutputStream os;
		File file;
		int i;
		string base_name;
		
		if (current_theme == "") {
			warning ("No name for theme.");
			return;
		}

		if (current_theme == "default.theme" || current_theme == "high_contrast.theme") {
			current_theme = "custom.theme";
			
			file = get_child (BirdFont.get_settings_directory (), current_theme);
			i = 2;
			base_name = "custom";
			while (file.query_exists ()) {
				current_theme = @"$(base_name)_theme_$(i).theme";
				file = get_child (BirdFont.get_settings_directory (), current_theme);
				i++;
			}
		}

		file = get_child (BirdFont.get_settings_directory (), current_theme);
		
		try {
			if (file.query_exists ()) {
				file.delete ();
			}
		} catch (GLib.Error e) {
			warning (e.message);
		}
		
		try {
			os = new DataOutputStream (file.create (FileCreateFlags.REPLACE_DESTINATION));
			os.put_string ("""<?xml version="1.0" encoding="utf-8" standalone="yes"?>""");
			os.put_string ("\n");
			
			os.put_string ("<theme>\n");
			foreach (string name in colors.keys) {
				Color color = colors.get (name);
				
				os.put_string ("\t<color ");
				
				os.put_string (@"name=\"$(Markup.escape_text (name))\" ");				
				os.put_string (@"red=\"$(color.r)\" ");
				os.put_string (@"green=\"$(color.g)\" ");
				os.put_string (@"blue=\"$(color.b)\" ");
				os.put_string (@"alpha=\"$(color.a)\"");
				
				os.put_string ("/>\n");
			}
			os.put_string ("</theme>\n");
			
			os.close ();
		} catch (GLib.Error e) {
			warning (e.message);
		}
		
		add_theme_files ();
	}

	static void parse_theme (File f) {
		string xml_data;
		XmlParser parser;
		
		try {
			FileUtils.get_contents((!) f.get_path (), out xml_data);
			parser = new XmlParser (xml_data);
			parse_colors (parser.get_root_tag ());
		} catch (GLib.Error e) {
			warning (e.message);
		}
	}
	
	static void parse_colors (Tag tag) {
		foreach (Tag t in tag) {
			if (t.get_name () == "color") {
				parse_color (t.get_attributes ());
			}
		}
	}
	
	static void parse_color (Attributes attributes) {
		string name = "";
		double r = 0;
		double g = 0;
		double b = 0;
		double a = 1;
		
		foreach (Attribute attr in attributes) {
			if (attr.get_name () == "name") {
				name = attr.get_content ();
			}
						
			if (attr.get_name () == "red") {
				r = double.parse (attr.get_content ());
			}
			
			if (attr.get_name () == "green") {
				g = double.parse (attr.get_content ());
			}
			
			if (attr.get_name () == "blue") {
				b = double.parse (attr.get_content ());
			}

			if (attr.get_name () == "alpha") {
				a = double.parse (attr.get_content ());
			}
		}

		colors.set (name, new Color (r, g, b, a));
	}
	
	public static void add_new_theme (SettingsDisplay d) {
		TextListener listener;

		listener = new TextListener (t_("New theme"), "", t_("Set"));
		
		listener.signal_text_input.connect ((text) => {
			if (text != "") {
				current_theme = text + ".theme";
				themes.add (current_theme);
			}
		});
		
		listener.signal_submit.connect (() => {
			TabContent.hide_text_input ();
			write_theme ();
			d.create_setting_items ();
		});
		
		TabContent.show_text_input (listener);		
	}
	
	public static string get_icon_file () {
		string icons;
		File f;

		return_val_if_fail (!is_null (current_theme), "icons.bf".dup ());
		return_val_if_fail (current_theme != "", "icons.bf".dup ());
		
		if (current_theme == "default.theme" || current_theme == "high_contrast.theme") {
			return "icons.bf".dup ();
		}
		
		icons = current_theme.replace (".theme", ".bf");
		f = SearchPaths.search_file (null, icons);
		
		if (f.query_exists ()) {
			return icons;
		}
		
		return "icons.bf".dup ();
	}
}

}
