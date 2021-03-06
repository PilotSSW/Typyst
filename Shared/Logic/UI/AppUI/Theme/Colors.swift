//
// Created by Sean Wolford on 3/7/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

class AppColor {
    /**
     * Backgrounds
     */

    public static var cardPrimaryBackground: Color {
        Color("Cards/Backgrounds/Primary")
    }

    public static var cardSecondaryBackground: Color {
        Color("Cards/Backgrounds/Secondary")
    }

    public static var cardTertiaryBackground: Color {
        Color("Cards/Backgrounds/Tertiary")
    }

    public static var cardOutlineRoundedScrollerBackground: Color {
        Color("Cards/Backgrounds/RoundedScrollerBackground")
    }

    public static var cardHeaderBackground: Color {
        Color("Cards/Backgrounds/Header")
    }

    /**
     * Cards
     */

    public static var cardOutlinePrimary: Color {
        Color("Cards/Outlines/Primary")
    }

    public static var cardOutlineSecondary: Color {
        Color("Cards/Outlines/Secondary")
    }


    /**
     * Objects
     */

    public static var selectedHeaderBackground: Color {
        Color("Objects/SelectedHeaderBackground")
    }

    public static var typeWriterCardHeaderBackground: Color {
        Color("Objects/HeaderBackground")
    }

    public static var ImageBackground: Color {
        Color("Objects/ImageBackground")
    }

    /**
     * Shadows
     */
    public static var objectShadowDark: Color {
        Color("Shadows/ObjectDark")
    }

    public static var objectShadowLight: Color {
        Color("Shadows/ObjectLight")
    }

    public static var textShadow: Color {
        Color("Shadows/Text")
    }

    /**
     * Text
     */
    public static var textBody: Color {
        Color("Text/Body")
    }

    public static var textBodyLight: Color {
        Color("Text/BodyLight")
    }

    public static var textHeader: Color {
        Color("Text/Header")
    }

    /**
     * UI Elements
     */
    public static var buttonBorder: Color {
        Color("Buttons/Border")
    }

    public static var buttonOvertone: Color {
        Color("Buttons/Overtone")
    }
    
    public static var buttonPrimary: Color {
        Color("Buttons/Primary")
    }

    public static var buttonSecondary: Color {
        Color("Buttons/Secondary")
    }

    public static var buttonTertiary: Color {
        Color("Buttons/Tertiary")
    }

    public static var buttonWarning: Color {
        Color("Buttons/Warning")
    }

    /**
     * Window
     */
    public static var windowBackground: Color {
        Color("Window/Background").opacity(0.15)
    }
}
