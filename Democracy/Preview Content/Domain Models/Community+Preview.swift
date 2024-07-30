//
//  Community+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation

extension Community {
    
    static var preview: Community {
        .init(
            id: UUID().uuidString,
            creatorId: UUID().uuidString,
            name: "TestCommunity",
            descriptionText: """
                     The Pennie Contact Center toll-free phone number 1-844-844-8040to check the status of an application they have entered at www.pennie.comif they received notification that their application was forwarded from DHS to the Pennie.to apply within Open Enrollment or a Special Enrollment Period (described earlier)

                     Healthcare.gov 1800-318-2596if youre leaving pennsylvania and need medicaid.PA Enrollment Services (Maximus) MCO 1-800-440-3989if you lost your medicaid insurance card and need a replacement or need to change your insurance company offering you medicaid.

                     Children’s Health Insurance Program (CHIP) 1-800-986-5437for replacement chip insurance card and to change chip insurance companyLIHEAP Hotline 1-866-857-7095Helps with LIHEAP applications.

                     PUBLIC HOUSING (Apply to all dont apply to just one waits are years long and make sure to update your applications annually to not get kicked off the list. You can find public housing in Westmoreland and Cambria County in approximately 3 months if you need something in Pennsylvania with public transit access.)Philadelphia Housing Authority2013 Ridge AvenuePhiladelphia, PA 19121Voice: (215) 684-4000TTY: for any department, use the PA relay system at 1 (800) 654-5984Email: info@pha.phila.govSpecific contact information for each department of The Philadelphia Housing Authority can be found here.

                     LANGUAGE ASSISTANCE PHA offers language assistance. If you are a limited English speaker, call PHA and a staff member will be able to answer your questions with the aid of an interpreter.PHA’s Limited-English Proficient Coordinator is:Tiffany PinkneyEmail: info@pha.phila.gov
                     """,
            creationDate: Date(),
            // representatives: Candidate.representativePreviewArray,
            memberCount: 255,
            rules: Rule.previewArray,
            resources: Resource.previewArray,
            categories: PostCategory.previewArray,
            tags: CommunityTag.previewArray,
            tagline: "Forum for economy, business, politics, stocks, bonds, product releases, IPOs, advice, news, investment, videso, pranks, and more",
            // alliedCommunities: [],
            settings: CommunitySettings.preview
        )
    }
    
    static var myCommunitiesPreviewArray: [Community] {
        var array: [Community] = []
        for index in 0...10 {
            array.append(
                Community(
                    id: UUID().uuidString,
                    creatorId: UUID().uuidString,
                    name: "My Community \(index)",
                    descriptionText: """
                             Welcome to the Community, blah, blah, blah Welcome to the Community, blah, blah,
                             blah Welcome to the Community, blah, blah, blah Welcome to the Community, blah,
                             blah, blah Welcome to the Community, blah, blah, blah Welcome to the Community,
                             blah, blah, blah
                             """,
                    creationDate: Community.preview.creationDate,
                    // representatives: Community.preview.representatives,
                    memberCount: 255,
                    rules: Community.preview.rules,
                    resources: Community.preview.resources,
                    categories: PostCategory.previewArray,
                    tags: [],
                    tagline: "Community Tagline",
                    settings: CommunitySettings.preview
                    // alliedCommunities: [],
                ))
        }
        return array
    }
}
