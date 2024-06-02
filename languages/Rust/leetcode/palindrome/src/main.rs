fn main() {
    let x = is_palindrome(55);
    print!("{}", x);
}

pub fn is_palindrome(x: i32) -> bool {
    let xStr = format!("{}", x);
    let bytes = xStr.as_bytes();

    let mut isPalindrome = true;
    let mut i = 0;
    while i < bytes.len() / 2 && isPalindrome {
        if bytes[i] != bytes[bytes.len() - 1 - i] {
            isPalindrome = false;
        }
        i = i + 1;
    }
    return isPalindrome;
}