//
//  FaqDataSource.m
//  NSW
//
//  Created by Stephen Grinich on 7/21/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "FaqDataSource.h"
#import "FaqItem.h"

@implementation FaqDataSource

NSMutableArray *parsedFaq;


- (id)init {
    self = [super initWithDataFromFile:@"faq.html"];
    
    return self;
}

- (void)parseLocalData{
    [self parseFaqFromHtml];
    [super parseLocalData];
}

-(void)parseFaqFromHtml{
    
    parsedFaq = [[NSMutableArray alloc] init];
    NSString *rawHTML = [[NSString alloc] initWithData:self.localData encoding:NSUTF8StringEncoding];
    NSString *afterModuleNav = [rawHTML componentsSeparatedByString:@"moduleNav"][1];
    NSString *pertinentContent = [afterModuleNav componentsSeparatedByString:@"<div class=\"feedLink\">"][0];

    NSString *itemPrefixPattern = @"<li class=\"item number\\d+?\"><strong><a href=";
    NSString *dummy =  @" NEVERSEETHIS ";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:itemPrefixPattern options:0 error:nil];
    NSRange range = NSMakeRange(0, [pertinentContent length]);
    NSString *modified = [regex stringByReplacingMatchesInString:pertinentContent options:0 range:range withTemplate:dummy];

    NSMutableArray *splitFaqLines = (NSMutableArray *) [modified componentsSeparatedByString:dummy];
    [splitFaqLines removeObjectAtIndex:0];
    
    
    for (id obj in splitFaqLines){
        FaqItem *currentFAQ = [self parseItemFromString:obj];
        [parsedFaq addObject:currentFAQ];
    }
    
    
    NSString *creditAnswerString = @"New Student Week App, iOS: \n\nStephen Grinich '16 (Update for Fall 2015) Summer 2015.\n\nStephen Grinich '16, Alex Simonides '15, Evan Harris '15. (Carleton College Mobile Application Development class project) Spring 2014.\n\nStephen Grinich '16, (Software Developer, Design) Summer 2014.\n\n\nNew Student Week App, Android:\n\nRaven Pillmann '16 (Update for Fall 2015). Summer 2015\n\nStephen Grinich '16, (Software Developer, Design) Summer 2014.\n\n\nSpecial thanks to Louis Newman, Jeff Ondich, Ana Sontag, and Lee Clark.";
    FaqItem *creditItem = [[FaqItem alloc]initWithQuestion:@"Who made this app?" Answer:creditAnswerString Section:@"NewStudents"];
    [parsedFaq addObject:creditItem];
    
    // Registration FAQ items
    NSString *faqAnswerString = @"You are required to discuss your proposed registration with a faculty adviser prior to registration. Consequently, your first web registration step each term is to confirm that you have done this. You can (and should) complete this step before your priority time so that you don't need to mess with it when you're trying to register. Click on the Confirm Advising Meeting page at https://thehub.carleton.edu/ to do this. You may do this as soon as you've had your meeting with your adviser and as soon as the link title indicates the term in question.\n\nType the name of the faculty member you met with. Click Submit. An email will automatically be sent to your official adviser(s) informing him/her that you confirm meeting with the faculty member whose name you typed. You will not be allowed to continue with registration for the upcoming term until you have completed this step. You should understand that misrepresenting yourself during this registration step will be considered a conduct violation (i.e., knowingly furnishing false information to the College with intent to deceive).\n\nCollege policy also dictates that you must enter, update or confirm your emergency contact information within 100 days of registration. Go to the Students menu on the Hub and click on the Emergency Contact and Cell Phone link in the Personal Information section to do this.\n\nTo find out whether you are cleared for registration, click on the Am I Registration Ready? link on the Hub. Here you will be able to view your priority time, any registration holds you need to clear before registering, your advising flag and your emergency contact update status.";
    FaqItem *faqItem = [[FaqItem alloc]initWithQuestion:@"What do I need to do before I can register for courses?" Answer:faqAnswerString Section:@"Registration"];
    [parsedFaq addObject:faqItem];
    
    faqAnswerString = @"Starting with your priority time and running all the way through to the end of the drop/add period, you are able to change your course selections via the Hub. Prior to your priority time, you are allowed to create your online \"preferred sections\" list, where you may choose courses you wish to register for, which may expedite the registration process.\n\nPrior to registering, you must update your emergency contact information, indicate that you have met with your academic adviser, and clear any registration holds you may have, which can all be done via the Hub. Detailed instructions can be found here: https://apps.carleton.edu/campus/registrar/webregistration/preferredcoursereg/\n\nIn order to register for with Music Lessons or Studio Art courses, you must fill out the Music Scheduling Form and Studio Art Course Form Application, found on the registrar site, respectively. If the Art and Art History Department allows you in the studio art course, you will receive further instructions for registering.";
    faqItem = [[FaqItem alloc]initWithQuestion:@"How does web registration work?" Answer:faqAnswerString Section:@"Registration"];
    [parsedFaq addObject:faqItem];
    
    faqAnswerString = @"In general, students register in the following order:  seniors, juniors, sophomores, and first-years.  Within each class year, you will be assigned a registration time.  These times will change each term and the system is set up to give every student a registration time in the top, middle and bottom third of the class each year.  So if you get a low priority registration time this term, you can rest assured that next term it will be some other students turn to get a low number.\n\nSome classes, though, are designated as “sophomore priority,” in general because certain departments (especially in the sciences) have decided that they want to make sure that sophomore and first-years get a chance to begin an extended sequence of courses in that department early on.  Classes marked “sophomore priority” will be open first to sophomores, then first-years, and only then seniors and juniors.\n\nStarting with your priority time and running all the way through to the end of the drop/add period, you are able to change your course selections via the Hub. Prior to your priority time, you are allowed to create your online \"preferred sections\" list, where you may choose courses you wish to register for, which may expedite the registration process.\n\nPrior to registering, you must update your emergency contact information, indicate that you have met with your academic adviser, and clear any registration holds you may have, which can all be done via the Hub. Detailed instructions can be found here: https://apps.carleton.edu/campus/registrar/webregistration/preferredcoursereg/\n\nIn order to register for with Music Lessons or Studio Art courses, you must fill out the Music Scheduling Form and Studio Art Course Form Application, found on the registrar site, respectively. If the Art and Art History Department allows you in the studio art course, you will receive further instructions for registering.";
    faqItem = [[FaqItem alloc]initWithQuestion:@"What are \"priority registration times?\"" Answer:faqAnswerString Section:@"Registration"];
    [parsedFaq addObject:faqItem];
    
    faqAnswerString = @"Under Registration and Courses on the Hub, click on Register For Courses page. Here you will find various ways to manage the way you search for courses and manage your waitlist. One of the easiest ways to find the course you want to register for is under Search and Register for Sections.\n\nThis page gives you access to real time class offering information. You need only enter the information you wish to search by, but you must enter a term in the top box and at least one other selection criterion. Note that you can search by course level, but be sure to review all options in the course level drop down box before making your selection:  for example, selecting 100-level will not pull up labs numbered in the 100s because labs have their own course levels.\n\nHint: We recommend that you enter the search parameters for all of the courses you wish to register for. When you click on submit, all of the courses that fulfill your selection criteria, up to 99 sections (including mandatory co-requisites that you forgot to select), will be listed in alphabetical order by subject.\n\nOnce you've entered your search parameters, click Submit.\n\nBy selecting an Action for the classes you’ve selected, you can waitlist, register, or drop a course you’ve found on the Hub. See here: https://apps.carleton.edu/campus/registrar/webregistration/preferredcoursereg/ for a more detailed guide explaining the differences between registering and waitlisting and how to do both.";
    faqItem = [[FaqItem alloc]initWithQuestion:@"How do I register for classes?" Answer:faqAnswerString Section:@"Registration"];
    [parsedFaq addObject:faqItem];
    
    faqAnswerString = @"Yes you can. Simply go through the normal registration process and add courses to your list as before. Once you priority registration slot comes around you will be able to select \"Register for previously selected sections\" on the Register for Courses page on the Hub and set the Action for desired courses to Register.";
    faqItem = [[FaqItem alloc]initWithQuestion:@"Can I find and save a list of possible courses before my priority registration slot?" Answer:faqAnswerString Section:@"Registration"];
    [parsedFaq addObject:faqItem];
    
    faqAnswerString = @"Certain courses require that you fill out additional forms once you have registered, including music and studio arts. The Studio Art form is a web form you will complete on-line and it will be submitted to the Art office when you click submit.\n\nStudio Arts: The Studio Art form is a web form you will complete on-line and it will be submitted to the Art office when you click submit. You can also fill the Studio Art registration form out on the screen, and then print them out and deliver them to the specified office. Some forms require obtaining various signatures first. If you want to keep a copy for yourself, print two or save the file after you have filled it out. You can also just print the forms and fill them out by hand, but that's not so tidy.\n\nStudio Arts Registration Link: https://apps.carleton.edu/curricular/arts/courses/registration/members_only/\n\nMusic: You must fill out a music scheduling form to indicate when you can meet for lessons and return it to the Music Department Office. That form can be found at the link below:";
    faqItem = [[FaqItem alloc]initWithQuestion:@"What do I have to do to register for music or studio arts courses?" Answer:faqAnswerString Section:@"Registration"];
    [parsedFaq addObject:faqItem];
    
    faqAnswerString = @"Students are allowed to take between 12 and 24 credits per term, with the standard load  being 18 credits. In order to take 23 or 24 credits, students must petition the Academic Standing Committee for approval.\n\nPetitions from first-year students will not be considered by the ASC, except in cases involving participation in applied music courses and theatrical groups.";
    faqItem = [[FaqItem alloc]initWithQuestion:@"How many credits should I be taking/am I allowed to take each term?" Answer:faqAnswerString Section:@"Registration"];
    [parsedFaq addObject:faqItem];
    
    faqAnswerString = @"The Registrar's Office notifies students via email when an instructor has given them permission to enroll in a waillisted course. The email will include registration instructions and an expiration time; register before that time or your seat will be given to the next student. To register for a waitlisted course in which you have been given permission to enroll, select \"Register\" in the left-hand drop-down box of your planned courses (Manage My Waitlist) and click Submit.\n\nTo remove yourself from a waitlist, select \"Remove\" in the left-hand drop-down box of your planned courses (Manage My Waitlist) and click Submit.";
    faqItem = [[FaqItem alloc]initWithQuestion:@"What are my options for registering from a waitlist position?" Answer:faqAnswerString Section:@"Registration"];
    [parsedFaq addObject:faqItem];
    
    faqAnswerString = @"If you experience technical difficulties during registration, call the Help Desk at 507-222-5999. Should general system failure stop your class from registering, you will receive an email from the registrar providing further information about how to proceed.";
    faqItem = [[FaqItem alloc]initWithQuestion:@"What should I do if the registration system fails during registration?" Answer:faqAnswerString Section:@"Registration"];
    [parsedFaq addObject:faqItem];
    
    faqAnswerString = @"There are a number of considerations that go into selecting a course, including pure academic curiosity, fulfillment of requirements, and completion of a future course's prerequisites. Your academic adviser is available to help you decide which courses you should take based on these considerations.\n\nStudents can also take advantage of the drop/add period at the beginning of each term to sample courses and gain an understanding of what they will be studying, as well as contact the professor. Remember, you have four years at Carleton: there’s lots of time to explore areas that you may never have considered exploring before.\n\nSome students take the time to reach out to the instructors of courses that they’re considering before they register.  This gives them an opportunity to learn more about the course requirements, the professor’s goals for the course and expectations for the students, etc.  This can minimize the time involved in checking out courses during the first week of the term.";
    faqItem = [[FaqItem alloc]initWithQuestion:@"What if I am unsure about whether I want to take a course?" Answer:faqAnswerString Section:@"Registration"];
    [parsedFaq addObject:faqItem];
    
    faqAnswerString = @"Students may modify their registration for courses during the drop/add period at the beginning of each term. When the term begins on a Monday, the drop/add period ends at 11:59 p.m. on the Sunday following.  When the term begins on a different day of the week, this period ends at 11:59 p. m. on the fifth day of classes: for example, if the term begins on Wednesday, the drop/add period ends just before midnight on the following Tuesday.\n\nStudents may make changes in 10-week and second 5-week course registrations online via the Hub until the end of the drop/add period.  Students may also drop first 5-week courses via the Hub during the drop/add period. Drop/add cards must be used to add first 5-week courses and these cards must be submitted to the Registrar’s Office no later than 5:00 p.m. of the fifth day of the term.  Should an instructor believe that a student has missed too much of a course, the instructor can withhold permission to add a course.  After the above deadlines, students may use drop/add cards to add or drop second 5-week courses up until 5:00 p.m. of the fifth day of the second 5 weeks.  See the Academic Calendar for specific deadlines.\n\nDrop/add cards are yellow cards that students can pick up from the registrars office. They are required in order to add first 5-week courses during the first week of classes and late drop 10-week courses between the second and sixth week of the term.\n\nWhen using drop/add cards for anything other than a change from one section to another of a multiple section course, the signature of the instructor(s) involved and the adviser will be required. For a change of course section, only the instructor's signature will be required (see Change of Section for deadline information). However, a student registered for a course for which another section is offered for different credit must switch sections using the drop/add procedure during published deadlines; the adviser's signature is required.\n\nProvided that you don’t fall below the 12 credit per term minimum, courses may be “late” dropped until 5:00 p.m. on the seventh Friday of the term for 10-week courses, the third Friday of the term for first 5-week courses, and the eighth Friday of the term for second 5-week courses. Courses described as seminars may be late dropped only with the instructor's permission (which may be withheld). Courses numbered 100 and 400, as well as those courses related to the senior integrative exercise, may not be late dropped (see point 2 under Senior Integrative Exercise for sole exception to this policy). After the one-week drop/add deadline, a drop results in a grade notation of \"DRP\" on the transcript and is identified as \"course dropped after the normal drop/add period without penalty.\" A blue \"late-drop\" card is provided for this purpose, and both the instructor's and adviser's signatures are needed.\n\nNo course may be dropped after 5:00 p.m. on the day of the late drop deadline noted above.";
    faqItem = [[FaqItem alloc]initWithQuestion:@"During which time period am I allowed to modify my registration/courses?" Answer:faqAnswerString Section:@"Registration"];
    [parsedFaq addObject:faqItem];
    
    faqAnswerString = @"An Independent Study is an individual, non-research, directed study in a field of special interest, under the supervision of a faculty member. It allows a student to pursue an academic interest outside the listed course offerings, or explore in more depth an area of study that has been encountered in a previous course. An Independent Study should culminate in several short papers, a single paper, or any other project acceptable to the supervising faculty member and the student.\n\nIf an independent study number appears in the list of course offerings, a student may enroll in independent study with the consent of a professor.";
    faqItem = [[FaqItem alloc]initWithQuestion:@"What is an independent study, and how do I participate in one?" Answer:faqAnswerString Section:@"Registration"];
    [parsedFaq addObject:faqItem];
    
    
    // Send the data to the view controller if there's one linked, otherwise
    // copy it into self.dataList to be retrieved once a VC has been linked
    if (myTableViewController != nil){
        [myTableViewController setVCArrayToDataSourceArray:parsedFaq];
    } else {
        self.dataList = [NSArray arrayWithArray:parsedFaq];
    }
    

    
}

- (FaqItem *)parseItemFromString:(NSString *) htmlContact {
    
    NSString *question;
    NSString *answer;
    NSString *section;
    
    question = [self getQuestionFromString:htmlContact];
    answer = [self getAnswerFromString:htmlContact];
    section = [self getSectionFromString:htmlContact];
    
    return [[FaqItem alloc] initWithQuestion:question Answer:answer Section:section];
    
}


//Returns string "?faq_id=xxxxxx" for some ID xxxxx
- (NSString *)getIDFromString:(NSString *) htmlContact {
    NSString *beforeIDString = @"><strong><a href=\"";
    //everything after "><strong><a href="
    NSString *afterHREF =[htmlContact componentsSeparatedByString:beforeIDString][0];
    //everything before ">"
    NSString *idString = [afterHREF componentsSeparatedByString:@"\">"][0];
    
    return idString;
}

// Gets question portion of FAQ item
- (NSString *)getQuestionFromString:(NSString *) htmlContact {
    NSString *beforeDescriptionPattern = @"<strong><a href=\"?faq_id=\\d+?\">";
    NSString *dummy =  @" NEVERSEETHIS ";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:beforeDescriptionPattern options:0 error:nil];
    NSRange range = NSMakeRange(0, [htmlContact length]);
    NSString *modified = [regex stringByReplacingMatchesInString:htmlContact options:0 range:range withTemplate:dummy];
    NSString *splitItems =  [modified componentsSeparatedByString:@">"][1];
    NSString *question = [splitItems componentsSeparatedByString:@"</a"][0];
    
    
    return question;
    
}

-(NSString *)getSectionFromString:(NSString *)htmlContact{
    /* Sections will be in this order and include:
     -- NewStudents
     -- Housing
     -- OneCard
     -- PostOffice
     -- SHAC
     -- Advising
     -- ITS
     -- Language
     -- PrintServices
     -- DisabilityServices
     -- Miscellaneous
     */
    NSString *section;
    NSString *question = [self getQuestionFromString:htmlContact];
    
    /// Advising handbook questions
    if([question isEqualToString:@"What do I need to know about Priority Registration?"]){
        section = @"Advising";
    }
    else if([question isEqualToString:@"What is the purpose of academic advising?"]){
        section = @"Advising";
    }
    
    else if([question isEqualToString:@"O.K. So I'll take three courses my first term. How do I know which ones to take?"]){
        section = @"Advising";
    }
    
    else if([question isEqualToString:@"Will I have an adviser to help me register?"]){
        section = @"Advising";
    }
    
    else if([question isEqualToString:@"What is a Curricular Exploration requirement?"]){
        section = @"Advising";
    }
    
    else if([question isEqualToString:@"What do those letters at the end of course descriptions mean?"]){
        section = @"Advising";
    }
    
    else if([question isEqualToString:@"Do I have to take the placement tests?"]){
        section = @"Advising";
    }
    
    else if([question isEqualToString:@"Where do I get my books?"]){
       section = @"Advising";    }
    
    else if([question isEqualToString:@"What has to be done to fulfill the writing requirement?"]){
        section = @"Advising";
    }
    
    else if([question isEqualToString:@"What is \"scrunch\"?"]){
        section = @"Advising";
    }
    
    else if([question isEqualToString:@"How do I know what courses are available?"]){
        section = @"Advising";    }
    
    else if([question isEqualToString:@"What are the departmental policies on AP scores and placement?"]){
        section = @"Advising";
    }
    
    else if([question isEqualToString:@"What should I do to prepare for placement tests?"]){
        section = @"Advising";
    }
    
    else if([question isEqualToString:@"When do Carleton students declare a major? If I already know what I want to major in, can I declare a major early?"]){
        section = @"Advising";
    }
    
    else if([question isEqualToString:@"Are courses at St. Olaf available to me?"]){
        section = @"Advising";    }
    
    else if([question isEqualToString:@"What do I need to know about the 3-3 calendar?"]){
        section = @"Advising";    }
    
    else if([question isEqualToString:@"What is a concentration?"]){
        section = @"Advising";
    }
    
    
    // Housing questions
    
    else if([question isEqualToString:@"What size are the beds in the halls?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"I have additional questions about residential policies, problems, etc. Who can I turn to for answers?"]){
        section = @"Housing";    }
    
    else if([question isEqualToString:@"Can I move in any earlier than 8 a.m. on Tuesday, September 9?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"What furnishings are provided in the rooms? What should I bring myself?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"Is my personal property insured anywhere on campus (your room or storage)?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"Does every floor have bathrooms? What about co-ed bathrooms?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"What do I need to do if I want to host a party or an event?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"How can we decorate?"]){
        section = @"Housing";    }
    
    else if([question isEqualToString:@"Do I need to purchase my own printer?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"Will there be a phone in my room? What will my phone number be?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"Is cable TV available in College-owned houses?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"Are there laundry rooms in the halls and houses? How do you pay for laundry?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"How does Carleton encourage sustainable living and what can I do to help?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"Are refrigerators available in the residence halls?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"What are the policies regarding alcohol and drugs?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"When will I know what my housing assignment is for the fall and who my roommate will be?"]){
        section = @"Housing";    }
    
    else if([question isEqualToString:@"What meal plan are first year students on?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"How are first year student room assignments determined?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"Is there a place to store trunks, giant pieces of luggage, bikes and boxes?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"Are there kitchens and lounges on each floor? What equipment do they have?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"What are the differences between halls, larger houses, small houses?"]){
        section = @"Housing";
    }
    
    
    else if([question isEqualToString:@"What are quiet hours and when are they in effect?"]){
        section = @"Housing";    }
    
    else if([question isEqualToString:@"Is cable TV available in the residence halls?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"Is there a housing contract?"]){
        section = @"Housing";    }
    
    else if([question isEqualToString:@"Are pets allowed in the halls and houses?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"What is a substance free area?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"May I look at my room during the summer?"]){
        section = @"Housing";    }
    
    
    else if([question isEqualToString:@"Are the halls air conditioned?"]){
        section = @"Housing";
    }
    
    
    else if([question isEqualToString:@"How big are the rooms/halls/houses? How many people live on a floor?"]){
        section = @"Housing";
    }
    
    
    else if([question isEqualToString:@"What type of cleaning is provided in the residence halls and houses?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"Is smoking allowed in campus buildings or dorms?"]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"What is the \"housing freeze?\""]){
        section = @"Housing";
    }
    
    else if([question isEqualToString:@"Can I host visitors in my dorm?"]){
        section = @"Housing";
    }
    
    // ITS Questions
    
    else if([question isEqualToString:@"What kind of computer should I bring to Carleton?"]){
        section = @"ITS";
    }
    
    // New Students 2014 Questions
    
    else if([question isEqualToString:@"Are there any hotels within walking distance of campus?"]){
        section = @"NewStudents";
    }
    
    else if([question isEqualToString:@"Where can I find my Carleton Net ID and password?"]){
       section = @"NewStudents";
    }
    
    else if([question isEqualToString:@"What are my banking options in Northfield?"]){
        section = @"NewStudents";
    }
    
    else if([question isEqualToString:@"How do I get to Carleton?"]){
        section = @"NewStudents";
    }
    
    else if([question isEqualToString:@"What do I do if I lost my “Computing at Carleton” booklet?"]){
        section = @"NewStudents";
    }
    
    else if([question isEqualToString:@"Where do I get my books?"]){
        section = @"NewStudents";
    }
    
    // OneCard Questions
    
    else if([question isEqualToString:@"What should I do if I lose my OneCard?"]){
        section = @"OneCard";
    }
    
    else if([question isEqualToString:@"I'm a New Student. Can I get my OneCard over the summer?"]){
        section = @"OneCard";
    }
    
    
    else if([question isEqualToString:@"Can I get a refund if I withdraw, graduate or leave the college?"]){
        section = @"OneCard";
    }
    
    else if([question isEqualToString:@"How do I check my account balance(s)?"]){
        section = @"OneCard";
    }
    
    else if([question isEqualToString:@"Must all students and employees have a OneCard?"]){
        section = @"OneCard";
    }
    
    else if([question isEqualToString:@"Why is my photo on my OneCard?"]){
        section = @"OneCard";
    }
    
    else if([question isEqualToString:@"Can I withdraw funds from my Schillers account?"]){
        section = @"OneCard";
    }
    
    else if([question isEqualToString:@"What does a replacement OneCard cost?"]){
        section = @"OneCard";
    }
    
    else if([question isEqualToString:@"What does a replacement OneCard cost?"]){
        section = @"OneCard";
    }
    
    else if([question isEqualToString:@"Do Schillers carry over from year to year until a student graduates?"]){
        section = @"OneCard";
    }
    
    else if([question isEqualToString:@"How many Schillers should I pre-purchase?"]){
        section = @"OneCard";
    }
    
    // Post office questions
    
    else if([question isEqualToString:@"Where is my student mail box located?"]){
        section = @"PostOffice";
    }
    
    else if([question isEqualToString:@"How should I ship my personal belongings to Carleton?"]){
        section = @"PostOffice";
    }
    
    else if([question isEqualToString:@"How do I retrieve my packages at Carleton?"]){
        section = @"PostOffice";
    }
    
    else if([question isEqualToString:@"When is the Campus Post Office open?"]){
        section = @"PostOffice";
    }
    
    else if([question isEqualToString:@"What is my student mail/ship to address?"]){
        section = @"PostOffice";
    }
    
    else if([question isEqualToString:@"How do I ship my bicycle to Carleton?"]){
        section = @"PostOffice";
    }
    
    else if([question isEqualToString:@"Is Photo I.D. required for package pick up?"]){
        section = @"PostOffice";
    }
    
    // Print Services Questions
    
    else if([question isEqualToString:@"How do I establish my account for Personal print jobs?"]){
        section = @"PrintServices";
    }
    
    // Student health and counseling questions
    
    else if([question isEqualToString:@"Where can I find information about alcohol and other drug resources?"]){
        section = @"SHAC";
    }
    
    else if([question isEqualToString:@"Is there a peer I can talk to regarding health and wellness questions?"]){
        section = @"SHAC";
    }
    
    else if([question isEqualToString:@"Does Carleton College offer an insurance plan that I can purchase?"]){
        section = @"SHAC";
    }
    
    else if([question isEqualToString:@"What immunizations are required for admission to Carleton College?"]){
        section = @"SHAC";    }
    
    else if([question isEqualToString:@"I see a medical provider for chronic ongoing health condition. Can I continue care at Student Health and Counseling?"]){
        section = @"SHAC";    }
    
    else if([question isEqualToString:@"Are there fees to see health care providers at Student Health and Counseling?"]){
        section = @"SHAC";
    }
    
    else if([question isEqualToString:@"Are there 24 hour emergency services available to Carleton students?"]){
        section = @"SHAC";
    }
    
    else if([question isEqualToString:@"I anticipate needing on-going counseling for a psychological concern. Can I work with a psychologist at Student Health and Counseling?"]){
        section = @"SHAC";
    }
    
    else if([question isEqualToString:@"I need to receive allergy shots while I am at Carleton. Can I get them at Student Health and Counseling?"]){
        section = @"SHAC";
    }
    
    else if([question isEqualToString:@"Where do I go if I have a disability and need accommodations?"]){
        section = @"SHAC";
    }
    
    else if([question isEqualToString:@"What services are available at Student Health and Counseling?"]){
        section = @"SHAC";
    }
    
    else if([question isEqualToString:@"Can I use Student Health and Counseling if I don’t purchase the Carleton sponsored insurance plan?"]){
        section = @"SHAC";
    }
    
    else if([question isEqualToString:@"What do I do if I need prescription medicines while I am at Carleton?"]){
        section = @"SHAC";
    }
    
    
    // Disability services for students questions
    
    else if([question isEqualToString:@"How do I upload documents to Firefly?"]){
        section = @"DisabilityServices";
    }
    
    else if([question isEqualToString:@"Can I read a document from an online folder in 'regular' Kurzweil?"]){
        section = @"DisabilityServices";    }
    
    else if([question isEqualToString:@"What are the advantages/disadvantages of using Firefly?"]){
        section = @"DisabilityServices";
    }
    
    else if([question isEqualToString:@"How do I change the reading voice?"]){
        section = @"DisabilityServices";
    }
    
    else if([question isEqualToString:@"Which browsers support Firefly?"]){
        section = @"DisabilityServices";
    }
    
    else if([question isEqualToString:@"Can I stop Firefly from reading headers/footers?"]){
        section = @"DisabilityServices";
    }
    
    else if([question isEqualToString:@"Can Firefly read/translate text in other languages?"]){
        section = @"DisabilityServices";
    }
    
    else if([question isEqualToString:@"Can Kurzweil read text in languages besides English? Does it have translation abilities?"]){
        section = @"DisabilityServices";
    }
    
    else if([question isEqualToString:@"Can I save an audio recording of my document being read aloud?"]){
        section = @"DisabilityServices";
    }
    
    // Foreign Language Placement Testing
    
    else if([question isEqualToString:@"How do I fulfill the language requirement?"]){
       section = @"Language";
    }
    
    else if([question isEqualToString:@"Can I major in a language?"]){
        section = @"Language";
    }
    
    else if([question isEqualToString:@"How do I know what level to register for?"]){
        section = @"Language";
    }
    
    else if([question isEqualToString:@"When should I start language study at Carleton?"]){
        section = @"Language";
    }
    
    else if([question isEqualToString:@"Can I minor in a language?"]){
        section = @"Language";
    }
    
    else if([question isEqualToString:@"What opportunities will I have to practice my language outside of the classroom?"]){
        section = @"Language";
    }
    
    else if([question isEqualToString:@"Why does Carleton have a language requirement?"]){
        section = @"Language";
    }
    
    else if([question isEqualToString:@"What language should I take?"]){
        section = @"Language";
    }
    
    else if([question isEqualToString:@"What languages are offered at Carleton?"]){
        section = @"Language";
    }
    
    else if([question isEqualToString:@"I've placed out of the language requirement. Now what?"]){
        section = @"Language";
    }
    
    else if([question isEqualToString:@"What are the benefits of language proficiency?"]){
        section = @"Language";
    }
    
    else if([question isEqualToString:@"I'm bad at learning languages. What do I do?"]){
        section = @"Language";
    }
    
    
    else{
        section = @"Miscellaneous";
    }


    return section;
}




-(NSString *)getAnswerFromString:(NSString *) htmlContact{

    NSString *answer;
    NSString *question = [self getQuestionFromString:htmlContact];
    
    
    /// Advising handbook questions
    if([question isEqualToString:@"What do I need to know about Priority Registration?"]){
        answer = @"Carleton students register in priority order. That means that for most courses, seniors register first and first-year students register last. However, for courses designated “sophomore priority,” sophomores register first, then first-year students, then seniors, and lastly juniors. Within each class, students register three times a year and are assigned three registration priority numbers, one for each trimester. Each student’s numbers add up to 42. \n\nPractically speaking, this means you can’t always get into a course you want during the term you want to take it. When you have a “good” registration number, use it! You’ll soon learn which classes fill up quickly. If you have questions, your Liberal Arts Adviser, Resident Assistant (RA), or a student departmental adviser (SDA) can help you figure out how to strategize. Do keep in mind though that not all courses are offered every term.";
    }
    else if([question isEqualToString:@"What is the purpose of academic advising?"]){
        answer = @"Academic advising is an educational process intended to aid students in making decisions about their Carleton academic careers and lifelong career choices. Academic advisers for First- and Second-Year students are called \"Liberal Arts Advisers\" (whereas advisers for Juniors and Seniors are called \"Major Advisers\").  Liberal Arts Advisers coordinate course selection, discuss educational and career goals, and encourage students to consider questions of personal growth. Advisers also aid in planning academic programs and in referring students to other campus services. Students are responsible for pursuing this process as they deem appropriate for their needs; effective advising is only possible when communication yields an exchange of ideas. First- and second-year Liberal Arts Advisers are assigned generally; that is, a student thinking of majoring in studio art might have a mathematician as an adviser, or an aspiring chemist may be advised by an English professor. This is not a problem. \n\n In addition to your Liberal Arts Adviser, department chairs are available to meet with students during New Student Week and throughout the year. RAs, New Student Week Leaders (NSWLs), and Student Department Assistants (SDAs) are also available during New Student Week and beyond. You will also have a chance to attend an Academic Fair during your first week on campus to meet with faculty and student representatives from various departments.";
    }
    
    else if([question isEqualToString:@"O.K. So I'll take three courses my first term. How do I know which ones to take?"]){
        answer = @"All students must pre-register online for one Argument and Inquiry Seminar, specially designed for first-year students. In order to enroll in one, you can find the link on the New Student Checklist on the New Student Website.  Or through Course Navigator (see the New Student Website, under Registration, at http://go.carleton.edu/new). Almost all students who have not fulfilled the language requirement enroll in a language class sometime during their first year. If you place into Spanish 103, for instance, you'll wait until spring term to enroll. If you decide to start Japanese, you'll want to enroll your first term. What else? All departments have courses designed for incoming students. \n\nFor complete course descriptions, see the academic catalog. You will meet with your adviser during New Student Week and have a chance to drop/add courses you have registered for before classes begin.";
    }
    
    else if([question isEqualToString:@"Will I have an adviser to help me register?"]){
        answer = @"You will be assigned a Liberal Arts Adviser after summer registration, but before you arrive on campus. To advise you over the summer we have a number of staff and students to help you -- their numbers are listed on your New Student Checklist, which was in Mailing #1.  In addition, the Course Navigator on the New Students site will help you organize your registration decision-making process.";
    }
    
    else if([question isEqualToString:@"What is a Curricular Exploration requirement?"]){
        answer = @"Curricular Exploration requirements require you to take 36 credits in six different areas.  The specifics of this will be available in the Academic Catalog, but you needn’t worry about these requirements too much at first: no matter what you take your first term, you will inevitably be fulfilling some requirements.  \n\n lobal Understanding requirements require you to take six credits in a course that deal with International Studies and six credits in a course that deals in Intercultural Domestic Studies as well as earn proficiency in a language other than English. \n\n Quantitative Reasoning requires three courses designated as a “Quantitatively Rich Encounter.” \n\n Writing requirements require you to take a first-year \"Argument and Inquiry\" seminar, an additional six credit writing course, and submit a revised writing portfolio the spring of your sophomore year. \n\n Physical Education requirements require you to take four terms of physical education, all of which can be fulfilled by participating in approved club sports.";
    }
    
    else if([question isEqualToString:@"What do those letters at the end of course descriptions mean?"]){
        answer = @"Requirement Codes as indicated on each course description or in schedule of courses: \n\nAI = Argument and Inquiry Seminar (6 credits required). \n\nARP = Arts Practice (6 credits required). \n\nFSR = Formal or Statistical Reasoning (6 credits required). \n\nHI = Humanistic Inquiry (6 credits required).  \n\nDS = Intercultural Domestic Studies (6 credits required). \n\nIS = International Studies (6 credits required). \n\nLA = Literary/Artistic Analysis (6 credits required). \n\nLP = Language Proficiency, in a language other than English. \n\nLS = Science with Lab (6 credits required). \n\nNE = No Exploration Credit. \n\n PE = Physical Education. (Four terms of physical education, all of which can be fulfilled by participation in approved club sports). \n\nQRE = Quantitative Reasoning Encounter (3 courses required). \n\nSI = Social Inquiry (6 credits required). \n\nWR1 = Designates the Writing Component of an AI Seminar. \n\nWR2 = Second Writing Rich Course (6 credits required)";
    }
    
    else if([question isEqualToString:@"Do I have to take the placement tests?"]){
        answer = @"Certain SAT II scores may exempt you from some placement tests. For specifics on other placement tests, view the Placement Testing information on the New Students site and Carleton’s Prior Credits Policy on the Registrar's web site.";
    }
    
    else if([question isEqualToString:@"Where do I get my books?"]){
        answer = @"You will be able to purchase textbooks, manuals, and all necessary materials at The Carleton Bookstore located in the Sayles-Hill Campus Center. Most instructors hand out a list of required texts the first day of class; the bookstore also has a complete listing of required and recommended texts for each course. Once you’ve registered, you can order or look up the textbooks for your classes on the bookstore website: www.carletonbookstore.com. Just follow the textbook links. You can also call the bookstore with questions at 1-800-799-4148 or email them at bookstore@carleton.edu. \n\nIf your placement in certain courses (e.g., foreign language) will not be definite until early in the term, it is advisable to delay purchase of these textbooks until exact placement and registration are confirmed.";
    }
    
    else if([question isEqualToString:@"What has to be done to fulfill the writing requirement?"]){
        answer = @"Carleton's writing requirement has three components. First, you must successfully pass an argument and inquiry seminar - a writing rich course. Second, you must turn in a portfolio by the middle of your sixth term at Carleton. Information on the portfolio can be found at Carleton's Writing Program web site. You will also be receiving an actual portfolio when you arrive on campus. Third, you must complete another writing rich course sometime before you graduate. All writing rich courses are designated by a WR2 and are offered in most departments. ";
    }
    
    else if([question isEqualToString:@"What is \"scrunch\"?"]){
        answer = @"\"Scrunch\" refers to Carleton's Satisfactory/ Credit/No Credit (S/Cr/NC) grading option";
    }
    
    else if([question isEqualToString:@"How do I know what courses are available?"]){
        answer = @"Consult the Registrar's office website at: www.carleton.edu/campus/registrar/schedule.html";
    }
    
    else if([question isEqualToString:@"What are the departmental policies on AP scores and placement?"]){
        answer = @"See the Prior Credits Policy on the Registrar’s web site.";
    }
    
    else if([question isEqualToString:@"What should I do to prepare for placement tests?"]){
        answer = @"The purpose of the placement tests is to make sure you get into the right course for you. Cramming for them is not going to be useful -- to you or to us. Reviewing a subject you probably haven't looked at for three months, though, is a good idea.";
    }
    
    else if([question isEqualToString:@"When do Carleton students declare a major? If I already know what I want to major in, can I declare a major early?"]){
        answer = @"Carleton students declare majors spring term of their sophomore year. Students cannot declare earlier. Why not? We expect you will spend at least part of your first two years exploring the different fields of study that are part of a liberal arts curriculum. It’s amazing how often interests change on encounter with different subjects at the college level! We really want first-year students to strive for variety and exploration in all the distribution groups. We know, though, that some students enter college already planning to major in a certain field, while others have narrowed the possibilities. If you think you know what you want to major in, check the department web site to see if the department you are considering has suggested particular courses or sequences appropriate for first-year study.";
    }
    
    else if([question isEqualToString:@"Are courses at St. Olaf available to me?"]){
        answer = @"Yes. By special arrangement and if space is available, students may take courses at St. Olaf College which are not offered at Carleton. These courses count as part of the total credit load for the term. Contact the Registrar's Office for more information.";
    }
    
    else if([question isEqualToString:@"What do I need to know about the 3-3 calendar?"]){
        answer = @"You may have already noticed unusual features of Carleton's calendar. In some ways, it resembles the quarter calendar some of your friends or siblings may be on, but there are significant differences. Our academic year is divided into three terms—roughly ten weeks in length—with the school year running from early September to early June. Students generally enroll in only three six-credit courses each term (credits for participating in music and drama activities are extra). You register three times a year, changing courses each term after talking with your adviser. What does this mean in practical terms? For one thing, while students at semester schools have to fit their course work into eight terms over four years, Carleton students have twelve terms. A student planning to major in chemistry at a semester school probably needs to start chemistry the first term of the first year—the second semester at the latest—or the student will run into trouble fitting in all the requirements. Because you have twelve terms at Carleton, you can enter a major a bit later; in fact, Carleton students don't declare majors until the end of the sophomore year. As a result, Carleton professors recommend you spend some of your first year trying out new subjects.";
    }
    
    else if([question isEqualToString:@"What is a concentration?"]){
        answer = @"Students may elect to complete one of Carleton’s 16 concentrations in addition to a major. A concentration is an integrated interdisciplinary program that may strengthen and complement a major, but a student majoring in any department could potentially participate in any concentration. Concentrations bridge the boundaries of academic disciplines, promote communities of learning, and relate academic studies to the kinds of issues and opportunities students confront outside of Carleton.";
    }
    
    
    // Housing questions
    
    else if([question isEqualToString:@"What size are the beds in the halls?"]){
        answer = @"Carleton College uses bunkable beds with an 80\" (extra long) twin mattress. Most of our mattress dimensions are: 36\"x80\"x8\". When students arrive, the beds will not be bunked, they will be positioned at about 19\" above the floor. If students would like to bunk their bed, the pins are stored in the top drawer of the dresser. Custodial staff in the buildings may have some in storage if there are no pins in the room.";
    }

    else if([question isEqualToString:@"I have additional questions about residential policies, problems, etc. Who can I turn to for answers?"]){
        answer = @"The Residential Life staff oversee residential facilities (room assignments and changes, keys, damage charges), but more importantly, the area directors and resident assistants are the first line of assistance for students within their residential environment. The staff is here to help you—to answer questions, to plan fun floor and hall programs, to help you learn about Carleton and yourself, and to just listen. Central office professional and student staff members are available to advise students on any educational or personal concerns. \n\n In addition, the central staff selects, trains, and supervises area directors and resident assistants. They also develop and administer residential policies. The residential life staff is led by the director of residential life and an assistant director of residential life. We welcome your questions and suggestions; please e-mail us, stop by our office for information, to meet the staff, or to just learn your way around campus.";
    }
    
    else if([question isEqualToString:@"Can I move in any earlier than 8 a.m. on Tuesday, September 9?"]){
        answer = @"We are able to accommodate first year students who must arrive early because of travel difficulties or family conflicts. However, the earliest we can provide housing is Monday, September 8, at noon. There is a nominal fee of $30 which includes the cost of your room and meals for September 8. The charge will be applied to your student account in the Business Office. If you would like to reserve housing , please complete the Early Arrival Request for First Year Students form. We are very sorry but we cannot accept any reservations after August 15.";
    }
    
    else if([question isEqualToString:@"What furnishings are provided in the rooms? What should I bring myself?"]){
        answer = @"All rooms are furnished with a bunkable bedframe, 80\" (extra long) twin mattress, desk, desk chair, wardrobe or closet, trash can, mirror, and overhead light. Please note that lofts are not permitted. You are welcome to bring additional items to personalize your room: a small comfy chair, a desk lamp, etc. If you choose to bring a lamp, avoid halogens. During the past few years, halogen lamps have caused a large number of fires in residence halls across the country due to the intensity of heat they generate, and they are prohibited at Carleton. \n\n To protect and maintain the furniture for future residents, all room furniture must be kept in the room, and all lounge furniture must be kept in the lounges. Drying racks will be available to use for free for anybody living on the floor, and will be kept in a common area (usually a storage closet or lounge). \n\n The drying racks were made possible by the Students Organized for the Protection of the Environment and the Sustainability Revolving Fund as part of an effort to reduce dryer usage and campus-wide energy consumption. \n\n Students must provide their own linens which may be ordered from a linen company. The extra long twin size linens are also available at most major department stores. Our student staff have developed a listing of useful items to bring with you to campus. We encourage you to coordinate with your roommate to avoid duplicates.";
    }
    
    else if([question isEqualToString:@"Is my personal property insured anywhere on campus (your room or storage)?"]){
        answer = @"Carleton College does not insure and is not responsible for loss or damage from any cause to the personal property of students (including items in storage). Students are encouraged to explore insurance coverage with your family insurance agent or through Sallie Mae Insurance Services.";
    }
    
    else if([question isEqualToString:@"Does every floor have bathrooms? What about co-ed bathrooms?"]){
        answer = @"Most floors have two bathrooms (male and female) but some floors have three or more. If there are more than two, the third bathroom may be designated co-ed. Depending on the building and the types of bathrooms in that space, bathrooms may be gendered and/or co-ed.  Most bathrooms have showers and a few also have bathtubs. Residents of rooms with private bathrooms are responsible for keeping the bathroom clean.";
    }
    
    else if([question isEqualToString:@"What do I need to do if I want to host a party or an event?"]){
        answer = @"Your Area director has event registration forms with complete guidelines. Any use of public space in your hall (i.e., anywhere except your room) for a party or event requires an event registration form be submitted to Residential Life 48 hours prior to the event. Parties and events in your room do not need to be registered; however, they must be confined to your room and may not disturb others on the floor. \n\n Large events (more than five (5) guests per resident of the room) must be approved 48 hours before the event starting time. Large events must be held in lounges or other public spaces. The lounge must be reserved through the Hall Director five days in advance.";
    }
    
    else if([question isEqualToString:@"How can we decorate?"]){
        answer = @"We encourage you to decorate your room with posters/pictures that make your room your home. Please do not use nails, tacks or duct tape. To avoid damage to the walls and woodwork in your room, use the removable adhesive poster strips that are available in stores.";
    }
    
    else if([question isEqualToString:@"Do I need to purchase my own printer?"]){
        answer = @"No. Printers are available in the library and the many computer labs located around campus. For more information visit Printing Services website.";
    }
    
    else if([question isEqualToString:@"Will there be a phone in my room? What will my phone number be?"]){
        answer = @"Each room has a phone. Your phone number will always start with 507-222-. The last four digits of your number are determined by your room assignment. Your room and phone number will be available when you are notified about your housing assignment via email. You will receive an authorization code from Telecommunications which will make it possible for you to make long distance calls from your room phone.";
    }
    
    else if([question isEqualToString:@"Is cable TV available in College-owned houses?"]){
        answer = @"Some of the College-owned houses are wired for Cable TV installation. Residents of the houses must subscribe for service using house funds to secure the subscription. Information is provided to the residents of the houses regarding cable TV installation at the beginning of each academic year. Houses that may subscribe for service are: Allen House, Benton House, Chaney House, Geffert House, Huntington House, Prentice House, Stimson House, Watson House, Williams House, and Wilson Houses. Carleton College network cable has been installed to Berg House, Brooks House, Clader House, Collier House, Colwell House, Dacie Moses House, Dixon House, Douglas House, Dow House, Eugster House, Hall House, Hill House, Hunt Cottage, Hunt House, Jewett House, Nason House, Owens House, Parish House, Parr House, Rice House, and Scott House. The College network provides only the basic cable package. Telecommunications staff can respond to questions regarding the Carleton network cable.";
    }
    
    else if([question isEqualToString:@"Are there laundry rooms in the halls and houses? How do you pay for laundry?"]){
        answer = @"Each hall and most campus houses have laundry facilities on the main floor or in the basement. The laundry machines in the residence halls accept OneCards. Laundry machines in the houses still use quarters. Drying racks will be available to use for free for anybody living on the floor, and will be kept in a common area (usually a storage closet or lounge). The drying racks were made possible by the Students Organized for the Protection of the Environment and the Sustainability Revolving Fund as part of an effort to reduce dryer usage and campus-wide energy consumption.";
    }
    
    else if([question isEqualToString:@"How does Carleton encourage sustainable living and what can I do to help?"]){
        answer = @"Sustainability is becoming more and more important on Carleton’s campus. For example, Carleton students are encouraged to be conscious of their energy use by setting computers to energy-saving modes, turning off extraneous lights, using power strips that can be turned off at night, using energy-maximizing CFL (compact fluorescent) light bulbs, being conscientious about shower time and water use, using energy-maximizing settings on washers, thinking about air-drying clothes and minimizing wintertime heat loss by keeping windows closed and adjusting the heat to comfortable levels. Currently, drying racks are available to use for free for anybody living on the floor, and will be kept in a common area (usually a storage closet or lounge). The drying racks were made possible by the Students Organized for the Protection of the Environment and the Sustainability Revolving Fund as part of an effort to reduce dryer usage and campus-wide energy consumption. Sustainability is about creating and maintaining a long-lasting, healthy community and well as minimizing impact on the environment. The many student and campus-sponsored activities, programs and organizations at Carleton create a healthy, happy, sustainable community that is also sustainable in its low impact on the environment. We encourage you to be conscientious of the environmental impact of your purchases as we move towards being a more sustainable campus community.";
    }
    
    else if([question isEqualToString:@"Are refrigerators available in the residence halls?"]){
        answer = @"Refrigerators are available in every floor lounge. Many students enjoy having small refrigerators in their rooms, but they are by no means necessary since there is space in the floor refrigerator. Small residence hall or apartment-style refrigerators (no greater than 3.6 cubic feet) are permitted in the student rooms.";
    }
    
    else if([question isEqualToString:@"What are the policies regarding alcohol and drugs?"]){
        answer = @"Students are expected to make responsible decisions concerning the use of alcohol. The College recognizes and abides by all state laws, and will cooperate fully with civil authorities. Alcoholic beverages may be possessed and consumed (not sold) by anyone of legal drinking age (21). Alcohol is not allowed in public areas except at registered events. Alcohol may be served at registered events where a carding system, food, and alternative beverages are present. The illegal use, sale, distribution, or possession of drugs is prohibited anywhere on the Carleton campus. Education and counseling on alcohol and drugs is provided by staff members in Student Health and Counseling.";
    }
    
    else if([question isEqualToString:@"When will I know what my housing assignment is for the fall and who my roommate will be?"]){
        answer = @"Residential Life staff complete housing assignments for new students in mid July. As soon as all new students are housed, the class dean will send an email with the website where new students can find their room assignment and the name, address, phone number and e-mail address of their roommate(s). We hope that when you receive your assignment, you will contact your roommate(s) to become acquainted.";
    }
    
    else if([question isEqualToString:@"What meal plan are first year students on?"]){
        answer = @"First year students are assigned to the 20 meal plan. The 20 meal plan is Carleton’s full board plan. This plan offers 20 guaranteed meals per week in either Burton or East Dining Hall, three per day Monday through Saturday and two on Sunday, with $75 in dining dollars that may be used in the Sayles Café or the dining halls. \n\n A unique feature of the 20 Meal Plan is the meal equivalency. THIS IS NOT AVAILABLE WITH THE 5 or the 12 Meal Plan. Meal equivalencies are intended to provide more choice options for the 20 Meal Plan user, especially if all $75 dining dollars have been exhausted. A meal equivalency allows you to buy food in the Sayles Café by using one of your weekly meal plan meals. The 20 meal plan allows the use of 1 meal per week as a meal equivalency. If you use a meal equivalency in a given week, then you have 19 meals available to use in the dining halls. If you don’t use a meal equivalency in the Sayles Café in a given week, then you have 20 meals available in the dining halls. There is no carryover of meal equivalencies that don’t get used. All first-year students are automatically assigned to this plan for the year, but may choose the 12 meal plan for winter and/or spring terms. \n\n Unused meals do not carry over to the next day, week, or term. Unused dining dollars are also not carried over from term-to-term.";
    }
    
    else if([question isEqualToString:@"How are first year student room assignments determined?"]){
        answer = @"Remember that Roommate Preference Questionnaire you completed? Residential Life staff read each and every Roommate Preference Questionnaire and match students based on responses to the questions on the form. They take into consideration your habits and patterns. Students are sorted based on the main issues that tend to cause conflicts in roommate situations (room cleanliness, noise/activity levels in the room, and bed times). Once students are put into those broad categories, we look at their academic and extracurricular interests and the other personal information they share. We work to put students together who have some overlapping interests, but who are not identitical matches. We believe that part of the learning that takes place at a residential college is meeting and living with people who are different from you. Because of this philosophy, we strive to not place people from the same state or schools in the same rooms. Siblings are not placed together as roommates and we try not to place siblings in the same buildings together. We typically don't honor roommate or specific dorm requests either. We also don't place athletes from the same team together as roommates. We believe that all of our communities are great places to live and that each student will have a fulfilling experience in the living environment that they are assigned to.";
    }
    
    else if([question isEqualToString:@"Is there a place to store trunks, giant pieces of luggage, bikes and boxes?"]){
        answer = @"Yes, Carleton has limited storage available. Storage tickets can be purchased from the Bookstore. Contact Custodial Services or your building custodian to make arrangements to get into the secure storage area. We recommend that you confirm with your home owner's policy will cover any valuable items left in the storage areas. Storage insurance is not provided by the College. Custodial Services manages storage in the residence halls. The Storage Policy provides details about the types, size and cost of storage available. Student belongings remain in their rooms during the winter and spring breaks if they will be returning to campus the following term. Storage is available for students during the summer months, for those who will be on off campus study programs and for those who are taking extended leaves from campus. There are also self-storage units in the Northfield area: Greenvale Mini-Storage, 507-645-2332, Northside Self Storage, 507-645-8814, Self Storage, 507-645-8888, Southgate Mini Storage, 507-645-4547";
    }
    
    else if([question isEqualToString:@"Are there kitchens and lounges on each floor? What equipment do they have?"]){
        answer = @"There is a kitchen and lounge area on every floor but one. The kitchens have a sink, stove/oven, microwave, and refrigerator. We do not provide any cooking utensils so you may want to have a few essentials in your room. Many floors have floor funds which they use to purchase kitchen supplies such as dish soap and baking pans. Students who use the facilities are expected to clean the kitchen. Caution: items left in a public kitchen may disappear.";
    }
    
    else if([question isEqualToString:@"What are the differences between halls, larger houses, small houses?"]){
        answer = @"There are differences in architecture, room size and type, privacy of bathrooms, student class years and meal plan options.";
    }
    
    
    else if([question isEqualToString:@"What are quiet hours and when are they in effect?"]){
        answer = @"The most common and potentially aggravating problem with hall life is excessive noise. Campus-wide quiet hours start in the evening (around 11 PM) and end in the early morning (9 AM). Stereos, radios, TVs, and human voices interfere with the need for sleep, study, and quiet. The privilege of playing a stereo or socializing ceases when it disturbs someone else. Cooperating fully with requests for quiet is expected. During finals week, residents are expected to observe 24 hour quiet hours in residential halls. You don't have to be completely silent, just respect the needs of others.";
    }
    
    else if([question isEqualToString:@"Is cable TV available in the residence halls?"]){
        answer = @"There is cable TV available in the TV lounges of the residence halls. Cable TV is not available to the individual student rooms in the residence halls.";
    }

    else if([question isEqualToString:@"Is there a housing contract?"]){
        answer = @"The Conditions of Occupancy printed on the back side of the Room Condition Report is used in lieu of a housing contract at Carleton College. The Residential Policies (https://apps.carleton.edu/handbook/housing/) posted on these pages provide detailed information on all aspects of living in our residential halls and houses.";
    }
    
    else if([question isEqualToString:@"Are pets allowed in the halls and houses?"]){
        answer = @"Fish, yes. Dogs, cats, gerbils, birds, snakes, lizards, or any other animal unable to live in a small water-filled aquarium must stay home. You will want to keep in mind that you will be gone for six weeks over the winter break when selecting your fish and their tank.";
    }
    
    else if([question isEqualToString:@"What is a substance free area?"]){
        answer = @"The possession or use of alcohol, controlled substances and tobacco products by residents or their guests is prohibited in student rooms and public spaces in Substance Free Areas. If residents or their guests choose to use such substances outside of the Substance Free Area, the results of that choice must not have a negative impact upon residents or property upon return to the Substance Free Area. Residents are responsible for the behavior of their guests. Substance Free Areas are: Fourth Burton, Fourth Davis, Second Goodhue, Second Musser, Second Myers, Third Nourse, Rice House and Second Watson.";
    }
    
    else if([question isEqualToString:@"May I look at my room during the summer?"]){
        answer = @"Carleton College's halls and houses are actually occupied during the summer months by summer program participants. We are sorry but you'll need to wait it out with your fellow classmates until the residence halls officially open. ";
    }
    

    else if([question isEqualToString:@"Are the halls air conditioned?"]){
        answer = @"All campus halls and houses have centrally-controlled heating since Minnesota can get quite cold in the winter. The residential buildings are not air conditioned during the academic year. We recommend that students bring a fan with them or purchase one at one of the local discount stores when they arrive.";
    }
    
    
    else if([question isEqualToString:@"How big are the rooms/halls/houses? How many people live on a floor?"]){
        answer = @"The halls and houses vary in size a great deal. Floor plans for all residence halls/houses show the general layout of each room and floor. Staff are currently working to provide measurements for all rooms on campus. Our floor plans will be updated when that information is available.";
    }
    
    
    else if([question isEqualToString:@"What type of cleaning is provided in the residence halls and houses?"]){
        answer = @"The residence hall public areas (lounges, hallways, kitchens and bathrooms) are cleaned daily (Monday through Friday). Private areas (apartments, private bathrooms, adjoining bathrooms, common areas of a private room) are the responsibility of the residents of the room. Only during winter, spring and summer breaks will Custodial staff do a thorough cleaning of the private and adjoining bathrooms in the residence halls and the bathrooms, kitchens and main living areas in the apartments. Custodial Services provides vacuums and other basic cleaning supplies for student use. We have noted on the floor plans if cleaning is done during the term. If limited cleaning is provided, Custodial staff clean the public areas of the houses on a bi-weekly, weekly or daily basis. Residents of the houses are responsible for keeping the houses clean. Questions or concerns regarding cleaning can be referred to the Maintenance and Custodial Office, Ext. 4133.";
    }

    else if([question isEqualToString:@"Is smoking allowed in campus buildings or dorms?"]){
        answer = @"Carleton is a smoke-free campus. Smoking is prohibited in all indoor spaces, including but not limited to: all classrooms, all residential living areas, lounges, bathrooms, vending areas, hallways, indoor athletic facilities, dining halls, and social spaces such as Sayles-Hill Great Space and the Cave. Smoking is also prohibited in private offices. Smoking is allowed outside in designated areas only.";
    }
    
    else if([question isEqualToString:@"What is the \"housing freeze?\""]){
        answer = @"Although the Housing Freeze sounds like something related to cold months in Minnesota, it actually occurs during the first and last two weeks of each term. During the Housing Freeze no room changes can occur. The Freeze is designed to allow time to get settled into your room and get to know your roommate(s), to respect academic efforts at busy times of the term, and to give Residential Life staff members time to evaluate occupancy levels for the term.";
    }
    
    else if([question isEqualToString:@"Can I host visitors in my dorm?"]){
        answer = @"Of course you can host visitors. When inviting or hosting guests, please be considerate of your roommate(s) and floormates. Visitors are expected to follow the same guidelines as residents. We suggest that roommates discuss guidelines for their own rooms in terms of guests, activities, privacy, and study atmosphere. As with anything in this communal environment, study, rest, and privacy take precedence over visitation, guests, and recreation. Guests are not allowed to stay for more than three nights in a row.";
    }

    // ITS Questions
    
    else if([question isEqualToString:@"What kind of computer should I bring to Carleton?"]){
        answer = @"We don't make any recommendations with regard to PCs or Macs -- whichever you prefer is fine. It is important, however, that you bring a computer that's new enough to work on our network and run the applications you'll need to do your work.";
    }
    
    // New Students 2014 Questions
    
    else if([question isEqualToString:@"Are there any hotels within walking distance of campus?"]){
        answer = @"The Archer House—which is located downtown on Division Street, two blocks from Johnson House, the admissions building—is the closest hotel to Carleton’s campus. Another close hotel is the Country Inn, located on Highway 3, about 4 blocks from campus, or AmericInn, which is approximately a mile from campus. If family members plan to stay in either of these hotels, you will not need a car to get to campus. For more information about hotels, maps, and dining opportunities, check out the Northfield Chamber of Commerce website: http://www.northfieldchamber.com.";
    }
    
    else if([question isEqualToString:@"Where can I find my Carleton Net ID and password?"]){
        answer = @"The Carleton username and password were sent in Mailing #1. They can be found on the front of the “Computing at Carleton” booklet. To change your password, go to http://go.carleton.edu/password.";
    }
    
    else if([question isEqualToString:@"What are my banking options in Northfield?"]){
        answer = @"The banks available are Community Resource Bank, First National Bank, Premier Bank Minnesota, and Wells Fargo Bank. Not all of these banks are in walking distance of the campus, but with a car, are within five minutes. Wells Fargo and First National are within walking distance, and Wells Fargo and First National have ATMs in Sayles-Hill, the student center.";
    }
    
    else if([question isEqualToString:@"How do I get to Carleton?"]){
        answer = @"For driving directions to and from Carleton, information about buses for students to and from the airport, and maps of campus and Northfield, visit http://webapps.acs.carleton.edu/student/transport.";
    }
    
    else if([question isEqualToString:@"What do I do if I lost my “Computing at Carleton” booklet?"]){
        answer = @"Call the ITS Helpdesk at 507-222-5999 for help retrieving your username and/or password.";
    }
    
    else if([question isEqualToString:@"Where do I get my books?"]){
        answer = @"You will be able to purchase textbooks, manuals, and all necessary materials for your classes at The Calreton Bookstore located in the Sayles-Hill Campus Center. Most instructors hand out a list of required texts the first day of class; the bookstore also has a complete listing of required and recommended texts for each course.  \n\n ou can also order or look up the textbooks for your classes on the bookstore's website at www.carletonbookstore.com. Just follow the textbook links. \n\n You can also call the bookstore with questions at 800.799.4148 or email them at bookstore@carleton.edu. If your placement in certain courses (i.e., foreign language) will not be definite until early in the term, it is advisable to delay purchase of these textbooks until exact placement and registration have been confirmed.";
    }
    
    // OneCard Questions
    
    else if([question isEqualToString:@"What should I do if I lose my OneCard?"]){
        answer = @"Mark your OneCard LOST anytime day or night on the OneCard Dashboard, https://apps.carleton.edu/campus/onecard/dashboard/. This is an important step to take to freeze unauthorized use of the financial funds on your OneCard - Schillers, Dining Dollars and Meal Plans. You will be held responsible for financial transactions that occurred prior to marking your card lost on this web site.";
    }
    
    else if([question isEqualToString:@"I'm a New Student. Can I get my OneCard over the summer?"]){
        answer = @"New Students can get their OneCard after July 4. See https://apps.carleton.edu/campus/onecard/get_onecard/";
    }
    
    
    else if([question isEqualToString:@"Can I get a refund if I withdraw, graduate or leave the college?"]){
        answer = @"Balances less than $20 will be forfeited. Refund requests are accepted when a student withdraws, or an employee terminates employment with the college. Refund checks are processed when:\n\n (1) the account balance is $20.00 or more AND,  \n\n (2) there are no outstanding student charges with the Business Office, AND, \n\n 3) a written request is submitted to Campus Services onecard@carleton.edu. Graduating seniors with a Schillers balance of $20.00 or more do not need to submit a written request and will be issued a refund check from the Business Office in July after graduation (minus any outstanding fees due the college).";
    }
    
    else if([question isEqualToString:@"How do I check my account balance(s)?"]){
        answer = @"OneCard Dashboard (https://apps.carleton.edu/campus/onecard/dashboard/) is the place to check your account balance(s) and recent transaction history. Also, receipts record balances as do the scrolling displays on self service locations like laundry, vending and copiers.";
    }
    
    else if([question isEqualToString:@"Must all students and employees have a OneCard?"]){
        answer = @"OneCard serves as the official Carleton College form of identification for students and employees. Your legal name will be printed on your OneCard. All Carleton students, excluding non-degree candidates, are issued a OneCard which serves as the official Carleton College form of identification. The OneCard is necessary for gaining access to residence halls, entry to dining halls for students with a meal plan or Dining Dollars, checking out library materials, cashing checks, the Rec Center, and attending certain special events. Students are encouraged to have their OneCard with them at all times. All Carleton employees will be issued a OneCard. The OneCard is necessary for gaining access to certain buidlings, checking out library materials, cashing checks, and the Rec Center. Employees are encouraged to have their OneCard with them at all times.";
    }
    
    else if([question isEqualToString:@"Why is my photo on my OneCard?"]){
        answer = @"Your photo appears on your OneCard to prevent unauthorized or fraudulent use. It serves as your official Carleton College form of identification and will include your legal name.";
    }
    
    else if([question isEqualToString:@"Can I withdraw funds from my Schillers account?"]){
        answer = @"No, withdrawal of cash funds is not permitted from any OneCard account.  However, Schillers can be redeemed for purchases and services (https://apps.carleton.edu/campus/onecard/) at numerous campus locations. ";
    }
    
    else if([question isEqualToString:@"What does a replacement OneCard cost?"]){
        answer = @"The cost of your first OneCard is covered by Campus Services.  The $10.00 fee for replacement cards goes towards the purchase of card stock, printer ribbons, card laminate, equipment, and general operation costs.  When a replacement OneCard is issued, a $10 replacement fee will be charged to your Schiller Account.";
    }
    
    else if([question isEqualToString:@"What does a replacement OneCard cost?"]){
        answer = @"The cost of your first OneCard is covered by Campus Services.  The $10.00 fee for replacement cards goes towards the purchase of card stock, printer ribbons, card laminate, equipment, and general operation costs.  When a replacement OneCard is issued, a $10 replacement fee will be charged to your Schiller Account.";
    }
    
    else if([question isEqualToString:@"Do Schillers carry over from year to year until a student graduates?"]){
        answer = @"Yes, Schiller account funds automatically carry over from year to year for students and employees.  Refer to Schillers Terms & Conditions, https://apps.carleton.edu/campus/onecard/terms/, for refunds for graduating seniors.";
    }
    
    else if([question isEqualToString:@"How many Schillers should I pre-purchase?"]){
        answer = @"A student may need between $400 and $1000 Schillers per term, or $40 to $100 Schillers per week while on campus if they want to take advantage of the convenience that OneCard offers. You will have to decide for yourself. Some classes require more books than others, some students do laundry more frequently than others, etc. Listed below are factors to consider when determining how many Schillers to pre-purchase:  \n\n  Laundry: $20-$40 Schillers a term.\n\nTextbooks and supplies: $350-$700 Schillers a term.\n\nFood money beyond Meal Plans and Dining Dollars: $125-$250 Schillers a term.\n\nCopies, Postage, Vending, Student Health and Counseling misc.: $5 - $20 a term.";
    }
    
    // Post office questions
    
    else if([question isEqualToString:@"Where is my student mail box located?"]){
        answer = @"Student mail boxes are located outside of the Campus Post Office in the Sayles-Hill lobby. An alphabetical list of assigned student mail boxes is posted outside of the Campus Post Office. Never send cash in the mail.  Student mail boxes are unlocked and open to the lobby.";
    }
    
    else if([question isEqualToString:@"How should I ship my personal belongings to Carleton?"]){
        answer = @"During Summer and Winter breaks we forward mail and parcels home for students until about two weeks before the next term starts. If you want something to arrive before that, and stay at Carleton, please contact us and mark the parcel as \"HOLD FOR NEXT TERM.\" Pack bed linens in your suitcase if your arrival time does not match up with Campus Post Office service hours. Do not ship any box larger or heavier than you can carry comfortably to your room. Boxes should be firmly packed with cushioning around items and reinforced with packing tape. E-mail notifications will be sent the day parcels arrive, and are ready for pickup at the Post Office. \n\nAn alphabetical list of assigned student mail boxes is posted in the lobby outside of the Campus Post Office. Carleton College cannot assume responsibility for items stolen or damaged during shipment or while in storage.  Items lost or stolen after arrival at Carleton are the responsibility of the student, not the College.";
    }
    
    else if([question isEqualToString:@"How do I retrieve my packages at Carleton?"]){
        answer = @"1.) A parcel notification e-mail will be sent to your @carleton.edu address once a parcel is ready for pickup. Photo I.D. is required for package pick up. An alphabetical list of assigned student mail boxes is posted outside of the Campus Post Office located in the lobby of Sayles-Hill.\n\n2.) You will have to transport your own boxes from the Campus Post Office or a temporary storage location to your housing. Do not send boxes larger/heavier than you can carry across campus.";
    }
    
    else if([question isEqualToString:@"When is the Campus Post Office open?"]){
        answer = @"View Campus Post Office service hours at https://apps.carleton.edu/campus/postoffice/contact/";
    }
    
    else if([question isEqualToString:@"What is my student mail/ship to address?"]){
        answer = @"The address for all students at Carleton is: Full Name, 300 North College Street, Northfield, MN  55057. Box numbers should not be included, as they change every term.";
    }
    
    else if([question isEqualToString:@"How do I ship my bicycle to Carleton?"]){
        answer = @"Check with a bike shop near your home. Some bike shops will package a bike for shipping for a fee. UPS will ship a bicycle that is already properly packaged. Check out the helpful instructions offered at this web site: http://www.bikeflights.com/how_to_pack_a_bike.aspx";
    }
    
    else if([question isEqualToString:@"Is Photo I.D. required for package pick up?"]){
        answer = @"Yes - bring your OneCard, Driver's License, or Passport for identification purposes.";
    }
    
    // Print Services Questions
    
    else if([question isEqualToString:@"How do I establish my account for Personal print jobs?"]){
        answer = @"Yes - bring your OneCard, Driver's License, or Passport for identification purposes.";
    }
    
    // Student health and counseling questions
    
    else if([question isEqualToString:@"Where can I find information about alcohol and other drug resources?"]){
        answer = @"Student Health and Counseling (http://www.carleton.edu/campus/wellness) provides students with alcohol and drug assessment, treatment referrals and education about alcohol and other related drugs. For additional policy information, please refer to Carleton's alcohol and drug policy (https://apps.carleton.edu/campus/dos/handbook/policies/primary/?policy_id=21793). ";
    }
    
    else if([question isEqualToString:@"Is there a peer I can talk to regarding health and wellness questions?"]){
        answer = @"Yes. The Student Wellness Advocates (SWAs) facilitate health-related workshops and encourage Carleton students to lead healthy and balanced lives. SWAs also connect students with other peer leaders and make referrals to support staff on campus.";
    }
   
    else if([question isEqualToString:@"Does Carleton College offer an insurance plan that I can purchase?"]){
        answer = @"Yes.  Information about waiving or enrolling in the Student Illness and Accident Insurance is available on the Business Office website (https://apps.carleton.edu/campus/business/students/healthinsurance/).";
    }
    
    else if([question isEqualToString:@"What immunizations are required for admission to Carleton College?"]){
        answer = @"Information about requirements for incoming students is available on the Student Health and Counseling website.";
    }
    
    else if([question isEqualToString:@"I see a medical provider for chronic ongoing health condition. Can I continue care at Student Health and Counseling?"]){
        answer = @"We recommend that students with chronic health conditions make an appointment at the Allina Medical Clinic (507-663-9000) or the Family Health Medical Clinic (507-646-1494) to establish ongoing care. Conditions warranting this include: Diabetes, Crohn’s Disease, unstable asthma, ongoing orthopedic care, etc. ";
    }
    
    else if([question isEqualToString:@"Are there fees to see health care providers at Student Health and Counseling?"]){
        answer = @"No.  There is no charge for office visits with a medical provider in Student Health and Counseling (SHAC).  However, there are some related fees, which are outlined on the SHAC website.";
    }
    
    else if([question isEqualToString:@"Are there 24 hour emergency services available to Carleton students?"]){
        answer = @"There are no after-hour medical services provided through Student Health and Counseling (SHAC). Students may seek evening or weekend care at Allina Medical Clinic or at the Northfield Hospital. Carleton Security Services personnel are trained as medical First Responders and will assist with student emergencies 24 hours a day, and refer to ambulance or emergency room services as necessary. There is a psychologist on-call 24 hours a day when the academic term is in session to address psychological emergencies that occur after business hours. Please visit SHACs After-Hours/Emergency information website for more information: https://apps.carleton.edu/studenthealth/afterhours/.";
    }
    
    else if([question isEqualToString:@"I anticipate needing on-going counseling for a psychological concern. Can I work with a psychologist at Student Health and Counseling?"]){
        answer = @"Student Health and Counseling (SHAC) offers short-term individual and group counseling services to enrolled Carleton students. Counselors will meet with students needing longer-term care to help them find appropriate referrals in the community. Student Health and Counseling also provides the services of a psychiatrist whom students may see free of charge, upon referral from another SHAC staff member. Students who anticipate needing long-term counseling or who begin Carleton with a history of serious mental health concerns (chronic depression or anxiety, bipolar disorder, etc.) should consider establishing care with a local Northfield psychological provider. SHAC can help provide appropriate referrals to community providers.";
    }
    
    else if([question isEqualToString:@"I need to receive allergy shots while I am at Carleton. Can I get them at Student Health and Counseling?"]){
        answer = @"No. Student Health and Counseling does not offer allergy shot services. You can get your allergy injections at the Allina Medical Clinic  (507-663-9000) or Family Health Medical Clinic (507-646-1494)";
    }
    
    else if([question isEqualToString:@"Where do I go if I have a disability and need accommodations?"]){
        answer = @"All students with disabilities must register with Disability Services for Students before accommodations can be granted. Proper documentation is required. Disability Services for Students is housed the lower level of Davis Hall (near Student Health and Counseling) and can be reached at 507-222-4080. For further information please view the Academic Accommodations page of our website: https://apps.carleton.edu/campus/wellness/Disability_Services_For_Students/.";
    }
    
    else if([question isEqualToString:@"What services are available at Student Health and Counseling?"]){
        answer = @"Please see the Student Health and Counseling website, http://www.carleton.edu/campus/wellness/, for a full description of the medical and counseling services available.";
    }
    
    else if([question isEqualToString:@"Can I use Student Health and Counseling if I don’t purchase the Carleton sponsored insurance plan?"]){
        answer = @"Yes, but please note that health services beyond general diagnosis of illness and treatment of minor accidents provided by Student Health and Counseling are not included in the comprehensive fee of the College. Labs, x-rays, office visits and specialist referrals at the local health clinics/hospital are billed to your insurance company, or must be paid out of pocket. Many home-based HMO plans do not provide adequate coverage outside of your home area. Also, if you are considering study abroad options, these may not be covered under your current policy. We encourage you to review your current health insurance policy to verify that you are adequately covered while you pursue your academic interests at Carleton and abroad.";
    }
    
    else if([question isEqualToString:@"What do I do if I need prescription medicines while I am at Carleton?"]){
        answer = @"1) You can fill your prescription medicines before coming to Carleton at your home pharmacy. \n\n 2) You can have your health care provider write a prescription that you can fill at local Northfield Pharmacies. \n\n 3) You can make an appointment with one of the Nurse Practitioners at Student Health and Counseling to review your prescription needs. \n\n 4) If you are on Adderall or other meds for ADHD you need to make an appointment with one of Student Health and Counseling staff members who can clear you to meet with our staff Psychiatrist. He will review your case and write prescriptions to be filled in Northfield. We request that you have your home provider send us dictation regarding your diagnosis/progress and treatment program before you make an appointment at Student Health and Counseling. Fax to: 507-222-5038. We find this very helpful with your care.";
    }
    
    
    // Disability services for students questions
    
    else if([question isEqualToString:@"How do I upload documents to Firefly?"]){
        answer = @"Firefly can only read .kes and .txt files. If the document you wish to upload is in some other format, first open the file in Kurzweil and save it as a .kes file. Next, log in to Firefly. On your home screen, choose either your Private or Public folder. Documents uploaded to the Public folder will be visible to all Carleton Firefly users, while documents uploaded to your Private folder will be visible only to you. Finally, click the orange “Upload A File” button. Select the .kes file, and click “Open” to begin the upload.";
    }
    
    else if([question isEqualToString:@"Can I read a document from an online folder in 'regular' Kurzweil?"]){
        answer = @"Yes! If you put a file in your private or public folder in Firefly, that file will also be available through desktop Kurzweil. In addition, you can access files placed in other folders in the Universal Library through Kurzweil. PC: To access files saved in Firefly folders through Kurzweil, select File, “Open From Library.” A pop-up window will appear showing all accessible Firefly folders. Use this to navigate to the file you wish to open in Kurzweil. Mac: In the Mac version of Kurzweil, select the File menu, then “Open From Universal Library.” A pop-up window will appear showing all accessible Firefly folders. Use this to navigate to the file you wish to open in Kurzweil.";
    }
    
    else if([question isEqualToString:@"What are the advantages/disadvantages of using Firefly?"]){
        answer = @"Advantages: Firefly can be accessed anywhere with a web browser and an internet connection. This makes it a potentially more convenient and portable tool than Kurzweil. The reading voices in Firefly are, as a whole, superior to those in the Mac version of Kurzweil. Firefly is comparable to Kurzweil (both Windows and Mac versions) in its ability to translate text. Unlike Mac Kurzweil, Firefly can also intelligibly read text in Spanish. Disadvantages: Firefly is not a text editor, and it has limited annotation capabilities (Firefly only supports text highlighting). Firefly can only read .kes files. If you wish to upload a file of a different format, you must first create a .kes file using Kurzweil. As an online tool, Firefly is slightly slower than Kurzweil – it takes Firefly a moment to load text and move between pages.";
    }
    
    else if([question isEqualToString:@"How do I change the reading voice?"]){
        answer = @"The reading voice can be changed under the “Options” menu in the toolbar. We personally recommend Paul. Note: Violeta is intended to be used only when reading documents in Spanish.";
    }
    
    else if([question isEqualToString:@"Which browsers support Firefly?"]){
        answer = @"Firefly can be used in Chrome, Firefox, Safari, and Internet Explorer.";
    }
    
    else if([question isEqualToString:@"Can I stop Firefly from reading headers/footers?"]){
        answer = @"There is no tool within Firefly to block headers, footers, and other extraneous text from being read. However, previous changes made to the .kes file in Kurzweil will carry over to Firefly. When first creating the .kes file in Kurzweil, reading zones can be edited as described at https://apps.carleton.edu/disabilityservices/assistive_technology/Kurzweil/faq/?faq_id=390490. Zones which are deleted in this way will not be read aloud in Firefly.";
    }
    
    else if([question isEqualToString:@"Can Firefly read/translate text in other languages?"]){
        answer = @"In order to translate text, highlight the passage you want translated. Click the “Translation” button in the top right-hand corner of your screen and choose the desired language from the drop-down menu. Firefly can translate to and from: English, Spanish, French, German, Italian, Portuguese and Finnish. While the text translations seem accurate, only Spanish can be read proficiently by Firefly. If translating text into languages other than Spanish, we recommend using the desktop PC version of Kurzweil, which can both translate and read foreign languages much more fluently.";
    }
    
    else if([question isEqualToString:@"Can Kurzweil read text in languages besides English? Does it have translation abilities?"]){
        answer = @"For Mac: To translate into another language, highlight the text in question, open the Online menu, and select \"Translate.\" Selected the desired language from the drop-down menu, and press the \"Translate\" button to view your text in this language. Unfortunately, Kurzweil for Mac is sadly unable to read in languages other than English. \n\n For Windows: To read a document already in another language, scan/open the document in Kurzweil as normal. Under the Read menu, you can select between various reading languages with the \"Language\" option. Each language comes with a variety of new reading voices. Those voices with the prefix \"VW\" or the suffix \"-tel\" seem to be the best. Kurzweil can read the following languages: Spanish, French, German, Italian, Portuguese, and Finnish. From our testing, we have found that Kurzweil's ability to read Spanish and French is startlingly accurate, with highly intelligible voices. We cannot speak to Finnish. To translate into another language, highlight the text in question and press the \"Translate\" button in the Main Toolbar. Selected the desired languages from the drop-down menus, select \"Translate,\" and then \"Read.\"";
    }
    
    else if([question isEqualToString:@"Can I save an audio recording of my document being read aloud?"]){
        answer = @"For Mac: 1) Open your document in Kurzweil as normal. 2) Under the File menu, click \"Create Audio File.\" 3) Select your desired reading voice, and the speed at which you want the document to be read. 4) Uncheck the \"Copy to iTunes\" option, and click \"Ok.\" 5) Choose a filename and destination, and click \"Save.\" 6) Before logging out, be sure to save this file in your Home folder, thumb drive, or other secure location. For PC: 1) Open your document in Kurzweil. 2) Under the File menu, click \"Audio Files\" and then \"Create Audio File.\" 3) A dialogue box will appear stating that Kurzweil needs access to the Internet. Select \"Yes.\" 4) Click \"Ok\" on the resulting dialogue box. Exit the \"Create Audio File\" window, and close Kurzweil. 5) Launch Kurzweil once more, and repeat steps 1) and 2). 6) Choose your desired reading voice, and the speed at which you want your document to be read. 7) Uncheck \"Add to iTunes\" and \"Add to Windows Media Player.\" 8) Click \"Ok.\" 9) You will find your saved audio file in the \"Kurzweil 3000 Output Audio\" folder, located on the Desktop. Make sure to move it to your Home folder, thumb drive, or other secure location - if using a public lab machine, the file will be deleted immediately upon logging out!";
    }
    
    // Foreign Language Placement Testing
    
    else if([question isEqualToString:@"How do I fulfill the language requirement?"]){
        answer = @"You may meet the language requirement in four different ways:\n\n1) by testing out with an appropriate score in the CEEB Advanced Placement, Achievement examination, International Baccalaureate examination, or in another standardized examination selected by the faculty of a particular language in consultation with the Associate Dean of the College; or\n\n2) by satisfactory completion (grade of S, C- or better) of a language course numbered 204 (205 in the case of Japanese and Chinese); or\n\n3) by passing a proficiency examination designed or selected by the faculty of the particular language in consultation with the Associate Dean of the College; or\n\n4) in the case of fluent speakers of languages not taught at Carleton, by passing a special examination prepared by an expert. Visit the Language Exemption website, http://go.carleton.edu/exemption .";
    }
    
    else if([question isEqualToString:@"Can I major in a language?"]){
        answer = @"Regular majors are available in French: Literature, French: Cultural Studies, Greek, German, Latin, Russian and Spanish. Special majors in Chinese, Japanese or Romance Languages are available by petition. Majors are also available in Classical Languages, Classical Studies, and Latin American Studies.";
    }
    
    else if([question isEqualToString:@"How do I know what level to register for?"]){
        answer = @"Take the placement test! Go to https://apps.carleton.edu/curricular/languageplacement/";
    }
    
    else if([question isEqualToString:@"When should I start language study at Carleton?"]){
        answer = @"Whether you are continuing a language you studied in high school or are starting a new language, we encourage you to register for language in the first year. Beginning Greek and Latin are offered in the winter. All other languages begin in the fall term only.";
    }
    
    else if([question isEqualToString:@"Can I minor in a language?"]){
        answer = @"Students who fulfill requirements for advanced coursework beyond the language requirement receive a “Certificate of Advanced Study,” which is comparable to a minor at most other institutions.";
    }
    
    else if([question isEqualToString:@"What opportunities will I have to practice my language outside of the classroom?"]){
        answer = @"All language departments offer a variety of extra-curricular activities, including language tables, film screenings and special events. Parish House is a dorm open to upper class students interested in practicing their languages and participating in international programming. Each year, Carleton hosts 6-7 “language associates,” native speakers of various languages who live in Parish House, coordinate extra-curricular activities and assist the language faculty.";
    }
    
    else if([question isEqualToString:@"Why does Carleton have a language requirement?"]){
        answer = @"As a liberal arts college, Carleton challenges its students to study broadly as well as deeply, and to gain a larger understanding of the world they live in. In addition to the primary benefits that foreign language competency can offer (including basic communication, the ability to read foreign texts, and interaction with those of a different culture), learning another language offers a unique perspective on other cultures and worldviews. Learn more here: https://apps.carleton.edu/curricular/languageplacement/requirement/ ";
    }
    
    else if([question isEqualToString:@"What language should I take?"]){
        answer = @"If you have already achieved some degree of proficiency in a language and are excited about continuing, take the placement test and plan to enroll in the appropriate course. If you are not excited about continuing the language you studied in high school, consider starting a new language; many Carleton students fulfill the requirement in a language they have not previously studied. This is especially true for languages not commonly taught in high schools, including Arabic, Chinese, Japanese, Russian, Hebrew and Ancient Greek. For more detailed in formation, be sure to check out the link on \"Choosing a Language\" here: https://apps.carleton.edu/curricular/languageplacement/choosingFL/";
    }
    
    else if([question isEqualToString:@"What languages are offered at Carleton?"]){
        answer = @"Currently Carleton offers instruction in ten languages: Arabic, Chinese, French, German, Greek, Hebrew, Japanese, Latin, Russian, and Spanish. Norwegian can be taken through special arrangement with St. Olaf College.";
    }
    
    else if([question isEqualToString:@"I've placed out of the language requirement. Now what?"]){
        answer = @"Keep going! Some courses numbered in the 200s offer advanced work in conversation and composition; others introduce literature organized around a particular theme. Except where noted, these courses are open to first-year students with the necessary background.";
    }
    
    else if([question isEqualToString:@"What are the benefits of language proficiency?"]){
        answer = @" Career goals: Some jobs require knowledge of a foreign language, but many more present additional opportunities to multilingual applicants. Carleton graduates have used their language skills in any number of careers, including social work, medicine, law, international business, community organizing, foreign service, journalism, hospitality, education, the military, volunteer service, law enforcement and many others. \n\n Travel: Study or travel in a foreign country can be an incredibly rewarding and enriching experience. Off-campus seminars led by Carleton faculty are available in Chinese, French, German, Russian and Spanish. Carleton students may also enroll in programs offered by other institutions or by consortia of which Carleton is a member. A number of competitive Carleton fellowships provide additional opportunities for internships, research or service learning abroad. \n\n Interest in the literature, history, politics, or culture: Obviously, advanced study of the literature, history, politics or culture of a particular country or region requires proficiency in a language. Students are often surprised to learn that many graduate programs, especially in the humanities, require a reading knowledge of French, German or other languages, no matter what their area of specialization. \n\n Local immigrant populations:  Nearly 1 in 5 Americans speaks a language other than English at home. Spanish is the most common, followed by Chinese, French, German, Tagalog, Vietnamese, Italian, Korean, Russian and Polish. [Source: 2000 Census] Knowing another language can give you access to the cultural riches of immigrant communities, while opening up opportunities in business and volunteer service. \n\n Family background: Learning the language of your forebears can open lines of communication with non-English-speaking relatives, while deepening your understanding of your family’s roots. \n\n Sharpening intellectual skills: Learning a second language helps improve memory, critical thinking and study skills. Many students find that the discipline and sustained effort required to learn a language help them succeed in other academic endeavors.";
    }
    
    else if([question isEqualToString:@"I'm bad at learning languages. What do I do?"]){
        answer = @"Whether a result of variable experiences in high school or natural talents, all students have academic strengths and weaknesses. Free one-on-one tutoring is available for all levels of language study. Students who have a documented learning disability that interferes with their ability to learn a language should visit the Dean of the College website, here http://apps.carleton.edu/campus/doc/information_students/language_requirement/language_procedures/ , for information about the language exemption process.";
    }
    
    
    else{
        answer = @"";
    }
    

    
    
    return answer;
}








/************************

// returns answer to FAQ question. taking a long time right now. may just have to program code answers in
-(NSString *)getAnswerFromString:(NSString *) htmlContact{
    NSString *idNumberstring;
    NSString *question = [self getQuestionFromString:htmlContact];
    idNumberstring = [self getIDFromString:htmlContact];
    NSString *answer;
    
    idNumberstring = [idNumberstring componentsSeparatedByString:@"\""][1];
    NSString *urlBeforeID = @"https://apps.carleton.edu/newstudents/contact/faq/";
    NSString *answerURL = [NSString stringWithFormat:@"%@%@",urlBeforeID,idNumberstring];
    NSURL *urlRequest = [NSURL URLWithString:answerURL];
    NSError *err = nil;
    
    NSString *html = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
    
    if(err)
    {
        //Not connected to internet?
        NSLog(@"URL ERROR");
    }
    
    NSString *questionAndHTML = [NSString stringWithFormat:@"%@%@",question,@"</h3>"];
    NSString *afterQuestion = [html componentsSeparatedByString:questionAndHTML][1];
    NSString *almostAnswer = [afterQuestion componentsSeparatedByString:@"</p><ul class"][0];
    
    // if <div class=\"answer\"><p> is in almostAnswer
    if ([almostAnswer rangeOfString:@"<div class=\"answer\"><p>"].location != NSNotFound) {
        almostAnswer = [almostAnswer componentsSeparatedByString:@"<div class=\"answer\"><p>"][1];
    }
    
    // if <div class="answer"><p class="MsoNormal"> is in almostAnswer
    if ([almostAnswer rangeOfString:@"<div class=\"answer\"><p class=\"MsoNormal\">"].location != NSNotFound) {
        almostAnswer = [almostAnswer componentsSeparatedByString:@"<div class=\"answer\"><p class=\"MsoNormal\">"][1];
    }
    
    answer = [almostAnswer stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    answer = [answer stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    
    
    //strip html junk elements here
    answer = [self flattenHTML:answer];
    
    
    
    return answer;
    
    
}


// strips html junk away. this might create nonsense within descriptions but that's better than having random html cpde in them
- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
        
    } // while //
    return html;
    
}

*******************/






@end
