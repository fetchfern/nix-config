use std::process::Command;
use std::env;
use std::str;

fn parse_connection(content: &str) -> Option<&str> {
    let result = content.trim_start_matches("GENERAL.CONNECTION:").trim();
    
    if result.is_empty() {
        None
    } else {
        Some(result)
    }
}

fn main() -> anyhow::Result<()> {
    let interface = env::var("EWWMOD_NET_INTERFACE")?;

    let out = Command::new("nmcli")
        .arg("--terse")
        .arg("-f")
        .arg("GENERAL.CONNECTION")
        .arg("d")
        .arg("show")
        .arg(interface)
        .output()?;

    if out.status.success() {
        match parse_connection(str::from_utf8(&out.stdout)?) {
            Some(ssid) => println!("{ssid}"),
            None => println!(),
        }
    } else {
        eprintln!("Error: nmcli returned with non-zero exit status");
    }

    Ok(())
}
