use std::fs;
use std::env;
use std::io;
use thiserror::Error;

#[cfg(not(target_os = "linux"))]
compile_error!("for cool kids only!!!");

#[derive(Debug, Error)]
enum WirelessError {
    #[error("interface '{0}' not found or not connected")]
    InterfaceEntryMissing(String),
    #[error("failed to open file: {0}")]
    IoError(#[from] io::Error),
    #[error("parse error: {0}")]
    ParseError(String),
}

fn get_quality(dev_name: String) -> Result<i8, WirelessError> {
    use WirelessError::*;

    let stat = fs::read_to_string("/proc/net/wireless")?;

    for line in stat.lines() {
        if line.starts_with(&dev_name) {
            let qual = line
                .split_once(':')
                .ok_or(ParseError("no semicolon".to_owned()))?
                .1
                .trim_start()
                .trim_start_matches(char::is_numeric)
                .trim_start()
                .trim_start_matches(|c: char| c.is_numeric() || c == '.')
                .trim_start()
                .split_once('.')
                .ok_or(ParseError("no period found".to_owned()))?
                .0
                .parse::<i8>()
                .map_err(|e| ParseError(format!("cannot parse quality as signed byte: {e}")))?; 

            return Ok(qual);
        }
    };

    Err(InterfaceEntryMissing(dev_name))
}

fn quality_icon_utf8_suffix(quality: i8) -> u8 {
    // > -55 dBm == excellent
    // > -62 dBm == good
    // > -69 dBm == okay
    // > -76 dBm == meh
    //  anyelse  == bad 

    if quality > -55 {
        0xa8
    } else if quality > -62 {
        0xa5
    } else if quality > -69 {
        0xa2
    } else if quality > -76 {
        0x9f
    } else {
        0xaf
    }
}

fn main() -> anyhow::Result<()> {
    let dev_name = env::var("EWWMOD_NET_INTERFACE")?;

    let utf8_suffix = match get_quality(dev_name) {
        Ok(quality) => quality_icon_utf8_suffix(quality),
        Err(WirelessError::InterfaceEntryMissing(_)) => 0xae,
        Err(e) => { return Err(anyhow::anyhow!(e)); }
    };

    let bytes = [0xf3, 0xb0, 0xa4, utf8_suffix];

    use std::io::Write;
    let mut stdout = io::stdout();
    stdout.write_all(&bytes)?;
    stdout.write(&[b'\n'])?;

    Ok(())
}
