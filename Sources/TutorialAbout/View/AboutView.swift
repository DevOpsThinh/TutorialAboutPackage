/// Copyright (c) 2022 DevOpsThinh
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

public struct AboutView: View {

    private var items: [AboutModel] = []

    public init (react_items: [AboutModel]) {
        self.items = react_items
    }

    // MARK: - COMPILER DIRECTIVE
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var hsClass: UserInterfaceSizeClass?
    #endif

    // MARK: - SOME SORT OF VIEW
    public var body: some View {
        #if os(iOS)
        if hsClass == .compact {
            NavigationView {
                view
            }
            .accentColor(Color("AccentColor"))
        } else {
            view
        }
        #else
        view
            .frame(minWidth: 400, minHeight: 600)
        #endif
    }

    @ViewBuilder
    private var view: some View {
        VStack {
            AboutBackgroundView()
                .padding(.top, -15)

            List {
                Section(
                    header: Text(NSLocalizedString("IMPROVEMENT US", comment: "IMPROVEMENT US"))
                            .font(.custom("Nunito-Regular", size: 25, relativeTo: .largeTitle))
                ) {
                    ForEach(improvementCase(items: items)) {
                        AboutSectionView(aboutModel: $0)
                    }
                }

                Section(
                    header: Text(NSLocalizedString("CONNECTING WITH US", comment: "CONNECTING WITH US"))
                            .font(.custom("Nunito-Regular", size: 25, relativeTo: .largeTitle))
                ) {
                    ForEach(socialCase(items: items)) {
                        AboutSectionView(aboutModel: $0)
                    }
                }
            }
            .listStyle(.grouped)
            .padding(.top, -15)

            Spacer()
        }
        .navigationTitle(NSLocalizedString("About Us", comment: "About Us"))
        .navigationBarTitleDisplayMode(.automatic)
    }

    // MARK: - METHODS
    private func improvementCase(items: [AboutModel]) -> [AboutModel] {
        var improvementList = [AboutModel]()

        for item in items {
            if item.category == .improvement {
                improvementList.append(item)
            }
        }
        return improvementList
    }

    private func socialCase(items: [AboutModel]) -> [AboutModel] {
        var socialList = [AboutModel]()

        for item in items {
            if item.category == .social {
                socialList.append(item)
            }
        }
        return socialList
    }
}

private extension PreviewProvider {
    static var mockAboutModels: [AboutModel] {
        [
            AboutModel(category: .social, title: "Twitter", iconName: "twitter", url: .twitter),
            AboutModel(category: .social, title: "Facebook", iconName: "facebook", url: .facebook),
            AboutModel(category: .improvement, title: "Tell us your feedback", iconName: "chat", url: .feedback),
            AboutModel(category: .improvement, title: "Discover us on GitHub Profile", iconName: "github", url: .github)
        ]
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(react_items: mockAboutModels)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            .previewDisplayName("iPhone SE 2nd")
    }
}
