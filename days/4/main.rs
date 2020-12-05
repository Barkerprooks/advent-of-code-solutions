use std::fs::File;
use std::io::prelude::*;

fn check_items(items: &Vec<String>) -> bool {
    
    let mut valid = vec![
        "byr", "iyr", "eyr",
        "hgt", "hcl", "ecl",
        "pid"
    ];
    
    for item in items {

        let mut index: i8 = -1;
        let field = item.split(":")
            .next()
            .unwrap_or("");
        
        for (i, value) in valid.iter().enumerate() {
            if field == String::from(*value) && field != "" {
                index = i as i8;
            }
        }

        if index != -1 && valid.len() > 0 {
            valid.remove(index as usize);
        }
    }

    valid.len() == 0 
}

fn check_fields(records: &Vec<String>) -> u32 {
    
    let mut valid: u32 = 0;

    for record in records {
        
        if record == "" {
            continue;
        }

        let items = record.split_ascii_whitespace()
            .map(|s| s.to_string())
            .collect();
    
        if check_items(&items) {
            valid += 1;
        }
    }

    valid
}

fn check_hgt(value: &String) -> bool { 
    
    let bytes = value.as_bytes();
    let n1 = bytes.len() - 2; 
    let n2 = bytes.len() - 1;
    
    if bytes[n1] as char == 'i' && bytes[n2] as char == 'n' {
        
        let mut parts = value.split("in");
        let val = parts
            .next()
            .unwrap_or("")
            .parse::<u8>()
            .unwrap();

        if val >= 59 && val <= 76 {
            return true
        }

    } else if bytes[n1] as char == 'c' && bytes[n2] as char == 'm' {
        
        let mut parts = value.split("cm");
        let val = parts
            .next()
            .unwrap_or("")
            .parse::<u8>()
            .unwrap();

        if val >= 150 && val <= 193 {
            return true
        }
    }

    false
}

fn check_hcl(value: &str) -> bool {
    
    if value.as_bytes()[0] as char != '#' || value.len() != 7 {
        return false;
    }

    for ch in value.chars() {
        if ! (ch >= '0' && ch <= 'f' || ch == '#') {
            return false
        }
    }

    true
}

fn check_values(records: &Vec<String>) -> u32 {
    
    let mut valid: u32 = 0;

    for record in records {
        
        if record == "" {
            continue;
        }

        let items = record.split_ascii_whitespace()
            .map(|s| s.to_string())
            .collect();

        if !check_items(&items) {
            continue;
        }

        let mut is_valid = true;

        for item in items {
            
            let mut kv = item.split(":");
            let key = kv.next().unwrap_or("");
            let val = kv.next().unwrap_or("");

            is_valid = match key {
                "byr" => val.len() == 4 &&
                    val.parse::<u16>().unwrap() >= 1920 && 
                    val.parse::<u16>().unwrap() <= 2002,
                "iyr" => val.len() == 4 &&
                    val.parse::<u16>().unwrap() >= 2010 &&
                    val.parse::<u16>().unwrap() <= 2020,
                "eyr" => val.len() == 4 &&
                    val.parse::<u16>().unwrap() >= 2020 &&
                    val.parse::<u16>().unwrap() <= 2030,
                "hgt" => check_hgt(&String::from(val)),
                "hcl" => check_hcl(&val),
                "ecl" => val == "amb" || val == "blu" ||
                    val == "brn" || val == "gry" ||
                    val == "grn" || val == "hzl" ||
                    val == "oth",
                "pid" => val.len() == 9,                
                "cid" => true,
                _ => false
            };

            if !is_valid {
                break;
            }
        }

        if is_valid {
            valid += 1;
        }
    }

    valid
}

fn main() {

    let mut fd = File::open("input.txt")
        .expect("failed to open file");

    let mut buf = String::new();
    fd.read_to_string(&mut buf)
        .expect("failed to read file");

    let records = buf.split("\n\n")
        .map(|s| s.to_string())
        .collect();

    let a1 = check_fields(&records);
    let a2 = check_values(&records);

    println!("solution 1: {}", a1);
    println!("solution 2: {}", a2);
}
