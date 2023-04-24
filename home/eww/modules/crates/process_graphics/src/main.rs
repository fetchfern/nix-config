use std::path::PathBuf;
use std::env;
use image::GenericImageView;
use image::Pixel;

fn process_img(path: PathBuf) -> anyhow::Result<()> {
    image::open(path)?
        .pixels()
        .map(|px| {
            let a = px.2.to_rgba().0[3];
            let c = (a != 0) as u8 * 255;
            ((c, c), (c, a))
        });
    Ok(())
}

fn main() -> anyhow::Result<()> {
    let arg_paths = env::args()
        .skip(1)
        .map(PathBuf::from)
        .try_for_each(process_img)?;

    Ok(())
}
