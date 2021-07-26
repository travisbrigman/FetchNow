//
//  FetchNowTests.swift
//  FetchNowTests
//
//  Created by Travis Brigman on 7/25/21.
//

import XCTest
@testable import FetchNow

class FetchNowTests: XCTestCase {

    let favorites = Favorites()
    let tvc = TableViewController()
    
    func testFavoritesAdd() throws {
        let location = Location(lat: 36.17, lon: -86.76)
        let performerImages = PerformerImages(huge: "HUGE!")
        let perfomer = Performer(type: "performType", name: "performerName", image: "imageString", id: 1, images: performerImages, hasUpcomingEvents: true, primary: true, imageAttribution: "imageAtrribute", url: "http://wwww.apple.com", score: 1.0, slug: "slug", homeVenueID: 1, shortName: "shortName", numUpcomingEvents: 1, imageLicense: "license", popularity: 1, homeTeam: true, location: location, awayTeam: false)
        let venue = Venue(state: "TN", nameV2: "Venue Test", postalCode: "37211", name: "FetchNow Venue", url: "http://www.apple.com", score: 1.0, location: location, address: "123 Maple Street", hasUpcomingEvents: true, numUpcomingEvents: 1, city: "Nashville", slug: "Slug", extendedAddress: "0123 Maple Street, nowheresville", id: 1, popularity: 1, metroCode: 1, capacity: 100, displayLocation: "venue display location")
        let event = Event(type: "show", title: "test show", shortTitle: "tst shw", id: 1, dateTimeLocal: Date(), venue: venue, performers: [perfomer])
        
        favorites.add(event)
        XCTAssertTrue(favorites.contains(event))
    }
    
    func testFavoritesRemove() throws {
        let location = Location(lat: 36.17, lon: -86.76)
        let performerImages = PerformerImages(huge: "HUGE!")
        let perfomer = Performer(type: "performType", name: "performerName", image: "imageString", id: 1, images: performerImages, hasUpcomingEvents: true, primary: true, imageAttribution: "imageAtrribute", url: "http://wwww.apple.com", score: 1.0, slug: "slug", homeVenueID: 1, shortName: "shortName", numUpcomingEvents: 1, imageLicense: "license", popularity: 1, homeTeam: true, location: location, awayTeam: false)
        let venue = Venue(state: "TN", nameV2: "Venue Test", postalCode: "37211", name: "FetchNow Venue", url: "http://www.apple.com", score: 1.0, location: location, address: "123 Maple Street", hasUpcomingEvents: true, numUpcomingEvents: 1, city: "Nashville", slug: "Slug", extendedAddress: "0123 Maple Street, nowheresville", id: 1, popularity: 1, metroCode: 1, capacity: 100, displayLocation: "venue display location")
        let event = Event(type: "show", title: "test show", shortTitle: "tst shw", id: 1, dateTimeLocal: Date(), venue: venue, performers: [perfomer])
        
        favorites.add(event)
        favorites.remove(event)
        XCTAssertFalse(favorites.contains(event))
        
    }



}
