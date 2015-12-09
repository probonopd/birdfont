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

using Cairo;
using Math;
using Gee;

namespace BirdFont {

public class ScaledBackground : GLib.Object {
	ImageSurface image;
	ArrayList<ImageSurface> parts;
	int size;
	int part_width;
	int part_height;
	double scale;
	
	public ScaledBackground (ImageSurface image, double scale) {
		this.image = image;
		this.scale = scale;
		
		parts = new ArrayList<ImageSurface> ();
		
		size = 10;
		part_width = image.get_width () / size;
		part_height = image.get_height () / size;

		for (int y = 0; y < size; y++) {
			for (int x = 0; x < size; x++) {
				ImageSurface next_part;
				next_part = new ImageSurface (Format.RGB24, part_width, part_height);
				Context context = new Context (next_part);
				context.set_source_surface (image, -x * part_width, -y * part_width);
				context.paint ();
				parts.add (next_part);
			}
		}
	}
	
	public double get_scale () {
		return scale;
	}
	
	public ImageSurface get_image () {
		return image;
	}
	
	ImageSurface? get_part_at (int x, int y) {
		int index = y * size + x;

		if (x >= size || x < 0) {
			return null;
		}

		if (y >= size || y < 0) {
			return null;
		}
						
		if (unlikely (!(0 <= index < parts.size))) {
			warning (@"No part at index: $x, $y");
			return null;
		}
		
		return parts.get (index);
	}
	
	public ScaledBackgroundPart get_part (double offset_x, double offset_y, 
			int width, int height) {
				
		double image_width = part_width * size;
		double image_height = part_height * size;
		
		int start_x = (int) ((offset_x / image_width) * size) - 1;
		int start_y = (int) ((offset_y / image_height) * size) - 1;
		int stop_x = (int) (((offset_x + width) / image_width) * size) + 2;
		int stop_y = (int) (((offset_y + height) / image_height) * size) + 2;

		int assembled_width = (int) ((size + 2) * image_width);
		int assembled_height = (int) ((size + 2) * image_height);
		image = new ImageSurface (Format.RGB24, assembled_width, assembled_height);
		Context context = new Context (image);

		int start_offset_x = start_x * part_width;
		int start_offset_y = start_y * part_height;
		
		if (start_offset_x > 0) {
			start_x = -1;
			start_offset_x = start_x * part_width;
		}

		if (start_offset_y > 0) {
			start_y = -1;
			start_offset_y = start_y * part_height;
		}
				
		for (int y = start_y; y < stop_y; y++) {
			for (int x = start_x; x < stop_x; x++) {
				ImageSurface? part = get_part_at (x, y);
				
				if (part != null) {
					context.save ();
					
					context.set_source_surface ((!) part,
						(x - start_x) * part_width,
						(y - start_y) * part_height);
						
					context.paint ();
					context.restore ();
				}
			}
		}
		
		return new ScaledBackgroundPart (image, scale,
				start_offset_x, start_offset_y);
	}
}

}