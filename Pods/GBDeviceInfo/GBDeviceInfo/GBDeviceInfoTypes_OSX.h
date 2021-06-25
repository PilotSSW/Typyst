//
//  GBDeviceInfoTypes_OSX.h
//  GBDeviceInfo
//
//  Created by Luka Mirosevic on 14/03/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

typedef struct {
    /**
     The main display's resolution.
     */
    CGSize                                              resolution;

    /**
     The display's pixel density in ppi (pixels per inch).
     */
    CGFloat                                             pixelsPerInch;
} GBDisplayInfo;

/**
 Makes a GBDisplayInfo struct.
 */
inline static GBDisplayInfo GBDisplayInfoMake(CGSize resolution, CGFloat pixelsPerInch) {
    return (GBDisplayInfo){resolution, pixelsPerInch};
};
