use std::path::{Path, PathBuf};
use std::ffi::OsStr;
use std::env;
use image::GenericImageView;
use image::{ImageBuffer, Pixel};

fn process_img(path: &Path) -> anyhow::Result<(u32, u32, Vec<u8>)> {
    let mut new_pixels = Vec::new();
    let img = image::open(path)?;

    for px in img.pixels() {
        let a = px.2.to_rgba().0[3];
        let c = (a != 0) as u8 * 255;
        new_pixels.extend([c, c, c, a]);
    }



    Ok((img.width(), img.height(), new_pixels))
}

fn is_processed(path: impl AsRef<OsStr>) -> bool {
    let path_string = path.as_ref().to_string_lossy();

    if path_string.ends_with(".proc.png") {
        println!("skipping {}", path_string);
        true
    } else {
        println!("processing {}", path_string);
        false
    }
}

fn main() -> anyhow::Result<()> {
    let arg_paths = env::args()
        .skip(1)
        .map(PathBuf::from);

    for path in arg_paths {
        if is_processed(path.file_name().unwrap()) {
            continue;
        }

        let (w, h, pixels) = process_img(&path)?;

        let mut path = path;
        path.set_extension("proc.png");

        let img: ImageBuffer<image::Rgba<u8>, _> = ImageBuffer::from_vec(w, h, pixels).unwrap();
        img.save(path)?;
    }

    Ok(())
}
