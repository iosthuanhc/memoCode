    UITextField *activateText;
    
   -(void)textFieldDidBeginEditing:(UITextField *)textField{
    activateText = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    activateText = nil;

}
- (void)viewDidLoad {
[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWasShown:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    CGRect beforeKeybRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect afterKeybRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, afterKeybRect.size.height , 0.0);
    mainSettingScrollview.contentInset = contentInsets;
    mainSettingScrollview.scrollIndicatorInsets = contentInsets;
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 7.0) {
        
        if ( beforeKeybRect.size.height == afterKeybRect.size.height ) {
            CGFloat textBottom = activateText.frame.origin.y + activateText.frame.size.height - mainSettingScrollview.contentOffset.y;
            CGFloat scrollViewBottom = mainSettingScrollview.frame.size.height - contentInsets.bottom;
            if( textBottom > scrollViewBottom ) {
                CGPoint scrollPoint = mainSettingScrollview.contentOffset;
                scrollPoint.y += textBottom - scrollViewBottom;
                [mainSettingScrollview setContentOffset:scrollPoint animated:YES];
            }
        }
    }
    
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    mainSettingScrollview.contentInset = contentInsets;
    mainSettingScrollview.scrollIndicatorInsets = contentInsets;
}
