# -*- coding: utf-8 -*-
#
# Copyright (C) 2022 Diego Valverde
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

import re


def replace_macros(src):
    macros = {}
    src_out = []
    for line in src.splitlines():
        match = re.findall('^(.*)<->(.*)', line)
        if len(match) == 0:
            src_out.append(line)
        else:
            src_out.append('')
            key, val = match[0]
            macros[key.strip()] = val.strip()

    str_out = ''
    for line in src_out:
        new_line = line
        for key in macros.keys():
            new_line = new_line.replace(key, macros[key])
        str_out += new_line + '\n'
    return str_out


def preprocess(text):
    preprocessed_text = text

    # The grammar does not really allow you to put ',\n'
    # Let's just fix this in some pre-processing stage
    escapable_symbols = [ '\\/', '-', '+', '*', '<-', '|']
    for symbol in escapable_symbols:
        preprocessed_text = preprocessed_text.replace('{}\n'.format(symbol), symbol)

    preprocessed_text = preprocessed_text.replace('assert', '___funky_assert')
    preprocessed_text = replace_macros(preprocessed_text)

    return preprocessed_text
