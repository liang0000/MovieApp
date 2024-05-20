//


import SwiftUI

struct SlotPicker: View {
    var locations: [String] = ["AMK Hub", "Causeway Point", "Century Square"]
    @State private var isShowActionSheet = false
    @State private var selectedDate = false
    @State private var selectedSlot: BookingInfo? = BookingInfo(time: "", date: 15, day: "M")
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ekocheras Mall")
                .font(.title2.bold())
            
            VStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 30) {
                        ForEach(MockData1.sampleDateDay, id: \.id) { dateDay in
                            Button(action: {
                                if var slot = selectedSlot {
                                    slot.date = dateDay.date
                                    slot.day = dateDay.day
                                    selectedSlot = slot
                                } else {
                                    selectedSlot = BookingInfo(time: "", date: dateDay.date, day: dateDay.day)
                                }
                            }, label: {
                                VStack(spacing: 5) {
                                    Text(dateDay.day)
                                        .font(.caption)
                                    Text(String(dateDay.date))
                                        .padding(10)
										.bold(selectedSlot?.date == dateDay.date)
										.foregroundStyle(
											selectedSlot?.date == dateDay.date ?
											Color(.systemBackground) : Color(.label)
										)
										.background(
											selectedSlot?.date == dateDay.date ?
											Color.lightModeBlueDarkModeWhite : Color.clear
										)
                                        .clipShape(Circle())
                                }
                            })
							.foregroundStyle(Color(.label))
                        }
                    }
                    .padding()
                }
                
                Divider()
                
                HStack {
                    ForEach(MockData1.times, id: \.self) { time in
                        Button(action: {
                            selectedSlot?.time = time
                            isShowActionSheet = true
                        }, label: {
                            Text(time)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 10)
								.foregroundStyle(.white)
								.background(Color(.systemBlue))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        })
                    }
                }
				.padding(.vertical)
            }
			.background(Color(.tertiarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .actionSheet(isPresented: $isShowActionSheet) {
            ActionSheet(
                title: Text("\(fullDayName(selectedSlot?.day ?? "")), \(selectedSlot?.date ?? 0) January at \(selectedSlot?.time ?? "")"),
                message: Text("Ekocheras Mall"),
                buttons: [
                    .default(Text("Book"), action: {}),
                    .cancel()
                ]
            )}
    }
}

#Preview {
    SlotPicker()
}

private func fullDayName(_ abbreviation: String) -> String {
    switch abbreviation {
        case "M": return "Monday"
        case "T": return "Tuesday"
        case "W": return "Wednesday"
        default: return abbreviation
    }
}

struct MockData1 {
    static let sampleDateDay1 = DateDay(id: 1, day: "M", date: 15)
    static let sampleDateDay2 = DateDay(id: 2, day: "T", date: 16)
    static let sampleDateDay3 = DateDay(id: 3, day: "W", date: 17)
    static let sampleDateDay: [DateDay] = [sampleDateDay1, sampleDateDay2, sampleDateDay3]
    static let times: [String] = ["10:10", "13:30", "19:40"]
}

struct DateDay: Identifiable {
    let id: Int
    let day: String
    let date: Int
}

struct BookingInfo: Identifiable {
    var id: UUID = UUID()
    var time: String
    var date: Int
    var day: String
}
