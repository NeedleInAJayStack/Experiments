fn main() {
    let home = IpAddr::V4(127, 0, 0, 1);
    let loopback = IpAddr::V6(String::from("::1"));

    let x: i8 = 5;
    let y: Option<i8> = None;

    // let z = x + y;

    println!("Hello, world!");
}

enum IpAddr {
    V4(u8, u8, u8, u8),
    V6(String),
}
