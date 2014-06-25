//
//  ViewController.m
//  postTest
//
//  Created by Chang YuanYu on 2014/4/22.
//  Copyright (c) 2014年 Coretronic. All rights reserved.
//

#import "ViewController.h"
// import AFNetworking library header"
#import "AFNetworking.h"
// import indicator library header"
#import "MBProgressHUD.h"

static NSString *const BaseURLString =
    @"http://54.238.231.25/nsn/rest/v1/contact/get";

@interface ViewController ()
{
    NSMutableData *getResponseData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    [self loadWebserverData];
 
// use AFNetworking
//    [self loadWebserverData];
// use xcode method
    [self loadWebserverData2];
  /*
 NSString *string = [NSString stringWithFormat:@"%@weather.php?format=json",
 BaseURLString];
 NSURL *url = [NSURL URLWithString:BaseURLString];
 NSURLRequest *request = [NSURLRequest requestWithURL:url];


 // 2
 AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager
 manager];
 manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"
 text/html " ];

 AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
 initWithRequest:request];
 operation.responseSerializer = [AFJSONResponseSerializer serializer];


 [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
 id responseObject) {
 // 3
 //        self.weather = (NSDictionary *)responseObject;
 //        self.title = @"JSON Retrieved";
 //        [self.tableView reloadData];

 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

 NSLog(@"error %@,", error);
 // 4
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error
 Retrieving Weather"
 message:[error localizedDescription]
 delegate:nil
 cancelButtonTitle:@"Ok"
 otherButtonTitles:nil];
 [alertView show];
 }];

 // 5
 [operation start];
 */
  /*
 //設定伺服器的根目錄
 NSURL *hostRootURL = [NSURL URLWithString:BaseURLString];
 //設定POST的內容
 NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"signUp",
 @"cmd", userID, @"userID", password, @"password", nil];


 //產生控制request的物件
 AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:hostRootURL];

 //POST
 [client postPath:@"api.php" parameters:params
 success:^(AFHTTPRequestOperation *operation, id responseObject) {
 //request成功之後要做的事情
 //對responseObject編碼，並輸出結果。
 NSString *response = [[NSString alloc]initWithData:responseObject
 encoding:NSUTF8StringEncoding];
 NSLog(@"response:%@",response);
 NSError *err;
 //將responseObject編碼成JSON格式
 NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject
 options:NSJSONReadingMutableLeaves error:&err];
 //取的api的key值，並輸出
 NSDictionary *apiResponse = [json objectForKey:@"api"];
 NSLog(@"apiResponse:%@",apiResponse);
 //取的signUp的key值，並輸出
 NSString *result = [apiResponse objectForKey:@"signUp"];
 NSLog(@"result:%@",result);
 //判斷signUp的key值是否等於success
 if ([result isEqualToString:@"success"]) {
 //顯示註冊成功
 UIImageView *imageView = (UIImageView *)[self.view viewWithTag:5];
 [imageView setImage:[UIImage imageNamed:@"success.png"]];
 [_statusLB setText:@"Status:sign up successed"];
 }else {
 //顯示註冊失敗
 UIImageView *imageView = (UIImageView *)[self.view viewWithTag:5];
 [imageView setImage:[UIImage imageNamed:@"signUpFail.png"]];
 [_statusLB setText:@"Status:sign up fail"];
 }
 [MBProgressHUD hideHUDForView:self.view animated:YES];
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 //request失敗要做的事情
 NSLog(@"request error:%@",error);
 UIImageView *imageView = (UIImageView *)[self.view viewWithTag:5];
 [imageView setImage:[UIImage imageNamed:@"connectError.png"]];
 [MBProgressHUD hideHUDForView:self.view animated:YES];
 }];
 }else {
 //基本認證失敗
 [_statusLB setText:@"validate fail"];
 [MBProgressHUD hideHUDForView:self.view animated:YES];
 }
 */
}

// use xcode kit
-(void) loadWebserverData2
{
//    NSString *url = [NSURL URLWithString:[BaseURLString URLEncodedString]];
    NSURL *url = [NSURL URLWithString:BaseURLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:postD]
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if( connection )
    {
        getResponseData = [NSMutableData new];
    }
}


// callback -NSURLConnection
-(void) connection:(NSURLConnection*) connetion didReceiveData:(NSData *)data
{
    [getResponseData appendData:data];
}

-(void) connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    NSLog(@"error: %@", [error localizedDescription]);
}

-(void) connectionDidFinishLoading:(NSURLConnection*) connection
{
    NSLog(@"請求完成");
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:getResponseData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"result: %@", dict);
}



// use AFNetworking
-(void) loadWebserverData
{
    AFHTTPRequestOperationManager *manager =
    [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObject:@"text/html"];
    
    NSDictionary *parameters = [[NSDictionary alloc]initWithObjectsAndKeys:@"3975b96d45c45e852e080334dde69f7f5a966f3814036050489733c4438df5be3882452a7315cee29e7ff240ca033",@"sessionid",@"-72726810",@"random", nil];

    //--------MBProgressHUD----------------
    //啟動一個hud
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
    //設定hud的顯示文字
//    [hud setLabelText:@"connecting"];
    //--------MBProgressHUD----------------
    
    [manager POST:BaseURLString
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@" JSON: %@ ", responseObject);
              //       NSDictionary *responseJSONObj =[NSJSONSerialization
              // JSONObjectWithData:responseObj];
              
              NSLog(@"result:%@", [responseObject objectForKey:@"result"]);
              
              //--------MBProgressHUD----------------
              [MBProgressHUD hideHUDForView:self.view animated:YES];
              
          }
          failure:^(AFHTTPRequestOperation *operation,
                    NSError *error) {
              NSLog(@"error %@,", error);
              
              //--------MBProgressHUD----------------
              [MBProgressHUD hideHUDForView:self.view animated:YES];
          }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
