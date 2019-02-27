//
//  Encodable+Utils.swift
//  Nytimes
//
//  Created by Habib Ali on 27/07/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
