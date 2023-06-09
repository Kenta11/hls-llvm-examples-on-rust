// (C) Copyright 2016-2022 Xilinx, Inc.
// All Rights Reserved.
//
// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

use std::process::exit;

const N: usize = 50;

fn example(a: &[isize; N], b: &mut [isize; N]) {
    let mut buff: [isize; N] = [0; N];

    for i in 0..N {
        buff[i] = a[i];
        buff[i] = buff[i] + 100;
        b[i] = buff[i];
    }
}

fn main() {
    let mut r#in: [isize; N] = [0; N];
    let mut res: [isize; N] = [0; N];

    for i in 0..N {
        r#in[i] = i as isize;
    }

    example(&r#in, &mut res);

    for i in 0..N {
        if res[i] != ((i + 100) as isize) {
            println!("Test failed.");
            exit(1);
        }
    }

    println!("Test passed.");
    exit(0);
}
