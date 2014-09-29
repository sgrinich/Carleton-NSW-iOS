NSW
===
*An application for Carleton's New Student Week*

Notes on running it:
---
- Because we're using CocoaPods, you have to open ```NSW.xcworkspace``` **not** ~~```NSW.xcodeproj```~~, otherwise the app won't build
- Notifications will occur immediately because you are setting them for events from 2 years ago. If you want to check that they occur at the correct time, you have to manually set the device/emulator's date back to a day between 9-4-2012 and 9-9-2012 in the device settings
- Below is a checklist of everything that was suggested/desired and the ones that are actually functional are checked

Checklist:
---
- [x] Complete ```NSWEvent```, ```Contact```, and ```CarlTerm``` models
- [x] DataSource classes for all of the above
- [x] Functional UI
- [x] Drawer-style navigation with [SWRevealController](https://github.com/John-Lluch/SWRevealViewController)

- [x] Hunt down the evil character(s):trollface: that is(/are) [preventing us from decoding the ics file as proper UTF-8](https://github.com/BTIN/NSW/blob/master/NSW/EventDataSource.m#L29-L30):rage:
  - **Was** be fixed by loading from local data :point_down:
- [x] Get all the DataSources to download their network source files (ics, html, json) to local and read from local
  - [ ] Reload by checking if "date-modified" (probably not the actual term for that) was 1 day or more before current time
- [x] Get ```CarlTermDataSource``` reading from a file (waiting on Web Services to host and agree on data format)
- [x] Flesh out stub classes
- [x] COLORS 
- [ ] Write tests
- [x] Implement custom ```UITableViewCell``` subclass(es) for ContactVC and CarlTermVC
  - [x] Want accordian-style detail view without opening whole new view. ~~(maybe learn from [Expandable-Collapsable-TableView](https://github.com/singhson/Expandable-Collapsable-TableView)?)~~
- [ ] About page
- [x] App icon + splash screen graphic of NSW logo

Suggestions:
---
- [ ] Disable notification button after pressing
- [x] take away arrows from "Carl Speak"
- [x] make events scrollable 
- [ ] change notification button color when selected
- [x] swipe left and right animation on schedule days
- [ ] put arrows on each side of a day's title, so it would look like <- September 10 ->
- [ ] Put day of week in title
- [x] change "carl speak" icons
- [ ] have an actual splash screen
- [ ] display full names in "carl speak"
- [ ] be able to go to a day a few days over without having to swipe left or right all the way there (like a little calendar icon on right  of navbar)
- [x] constrain date to new student week
- [x] Put some blank space at top of menu close to the height of the navbar
- [x] Make taps in right margin close menu instead of acting on the center view
