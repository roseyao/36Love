//
//  RBYViewController.m
//  36Love
//
//  Created by Rose Yao on 1/27/15.
//  Copyright (c) 2015 Rose Yao. All rights reserved.
//

#import "RBYViewController.h"


@interface RBYViewController()

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *tapLabel;
@property (nonatomic, retain) NSTimer *timer;

@property  (nonatomic)      int     currentQuestionIndex;
@property (nonatomic, copy) NSArray *questions;

@end;

@implementation RBYViewController

@synthesize timer;
int secondsLeft=239;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    
    if (self) {
        _questions = @[@"Given the choice of anyone in the world, whom would you want as a dinner guest?",
                       @"Would you like to be famous? In what way",
                       @"Before making a telephone call, do you ever rehearse what you are going to say? Why?",
                       @"What would constitute a “perfect” day for you?",
                       @"When did you last sing to yourself? To someone else?",
                       @"If you were able to live to the age of 90 and retain either the mind or body of a 30-year-old for the last 60 years of your life, which would you want?",
                       @"Do you have a secret hunch about how you will die?",
                       @"Name three things you and your partner appear to have in common.",
                       @"For what in your life do you feel most grateful?",
                       @"If you could change anything about the way you were raised, what would it be?",
                       @"Take four minutes and tell your partner your life story in as much detail as possible.",
                       @"If you could wake up tomorrow having gained any one quality or ability, what would it be?",
                       @"If a crystal ball could tell you the truth about yourself, your life, the future or anything else, what would you want to know?",
                       @"Is there something that you’ve dreamed of doing for a long time? Why haven’t you done it?",
                       @"What is the greatest accomplishment of your life?",
                       @"What do you value most in a friendship?",
                       @"What is your most treasured memory?",
                       @"What is your most terrible memory?",
                       @"If you knew that in one year you would die suddenly, would you change anything about the way you are now living? Why?",
                       @"What does friendship mean to you?",
                       @"What roles do love and affection play in your life?",
                       @"Alternate sharing something you consider a positive characteristic of your partner. Share a total of five items.",
                       @"How close and warm is your family? Do you feel your childhood was happier than most other people’s?",
                       @"How do you feel about your relationship with your mother?",
                       @"Make three true “we” statements each. For instance, 'We are both in this room feeling ... '",
                       @"Complete this sentence: 'I wish I had someone with whom I could share ... '",
                       @"If you were going to become a close friend with your partner, please share what would be important for him or her to know.",
                       @"Tell your partner what you like about them; be very honest this time, saying things that you might not say to someone you’ve just met.",
                       @"Share with your partner an embarrassing moment in your life.",
                       @"When did you last cry in front of another person? By yourself?",
                       @"Tell your partner something that you like about them already.",
                       @"What, if anything, is too serious to be joked about?",
                       @"If you were to die this evening with no opportunity to communicate with anyone, what would you most regret not having told someone? Why haven’t you told them yet?",
                       @"Your house, containing everything you own, catches fire. After saving your loved ones and pets, you have time to safely make a final dash to save any one item. What would it be? Why?",
                       @"Of all the people in your family, whose death would you find most disturbing? Why?",
                       @"Share a personal problem and ask your partner’s advice on how he or she might handle it. Also, ask your partner to reflect back to you how you seem to be feeling about the problem you have chosen."
                       ];
        self.currentQuestionIndex = 102;
        
    }
    
    return self;
}

- (IBAction)showQuestion:(id)sender
{
    if (self.currentQuestionIndex == 102) {
        [self.startLabel setHidden:YES];
        [self.tapLabel setHidden:YES];
        self.currentQuestionIndex = 0;
    }
    

    if (self.currentQuestionIndex == 100) {
        [self.startLabel setHidden:NO];
        if (self.timer==nil) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerOver) userInfo:nil repeats:YES];
            self.tapLabel.text = @"";
            self.startLabel.text = @"4 minutes and 0 seconds";
        }
    }
    else if (self.currentQuestionIndex == 101) {
        if (timer!=nil)
        {
            [timer invalidate];
            timer=nil;
            secondsLeft=239;
        }
        self.startLabel.text = @"Thank you and please tell your friends";
        self.tapLabel.text = @"Tap to go start again :)";
        self.currentQuestionIndex = 102;
    }
    else if (self.currentQuestionIndex == [self.questions count]) {
        self.currentQuestionIndex = -1;
        [self.startLabel setHidden:NO];
        [self.tapLabel setHidden:NO];
        self.startLabel.text = @"Now stare into each other's eyes for 4 minutes";
        self.tapLabel.text = @"Tap to start";
        self.questionLabel.text = @"";
        self.currentQuestionIndex = 100;

    }
    else {
        NSString *question = self.questions[self.currentQuestionIndex];
        self.questionLabel.text = [NSString stringWithFormat:@"%d) %@", self.currentQuestionIndex+1, question];
        self.currentQuestionIndex++;
    }

}

- (void)timerOver
{
    if (secondsLeft==0) {
        self.currentQuestionIndex = 101;
        self.startLabel.text = @"Congrats lovers!";
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        
    }
    else {
        int seconds = (secondsLeft %3600) % 60;
        int mins = secondsLeft/60;
    
        if (mins == 0) {
            self.startLabel.text = [NSString stringWithFormat:@"%0d seconds", seconds];
        }
        else if (mins == 1) {
            self.startLabel.text = [NSString stringWithFormat:@"%0d minute and %0d seconds", mins, seconds];
        }
        else {
            self.startLabel.text = [NSString stringWithFormat:@"%0d minutes and %0d seconds", mins, seconds];
        }
        secondsLeft--;
    }
}


@end
