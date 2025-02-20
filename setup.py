# Copyright (c) 2018 Shoppimon LTD
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from setuptools import find_packages, setup

import majortomo

with open('README.md') as f:
    long_desc = f.read()

with open('VERSION') as f:
    version = f.read().strip()

setup(
    name='majortomo',
    version=version,
    description='Majortomo - ZMQ MDP 0.2 (Majordomo) Python Implementation',
    author='Shahar Evron',
    author_email='shahar@shoppimon.com',
    url='https://github.com/shoppimon/majortomo',
    packages=find_packages(),
    long_description=long_desc,
    long_description_content_type='text/markdown',
    license='Apache 2.0',
    install_requires=[
        "figcan",
        "pyyaml",
        "pyzmq",
    ],
    python_requires='>=3.6.0',
    test_require=[
        'pytest',
    ],
    include_package_data=True,
    package_data={
        'majortomo': ['py.typed']
    }
)
