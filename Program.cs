var builder = WebApplication.CreateBuilder(args);


// This package method routes all AWS Lambda traffic through your app pipeline.
builder.Services.AddAWSLambdaHosting(LambdaEventSource.HttpApi);

builder.Services.AddControllers();

// Add services to the container.
builder.Services.AddRazorPages();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseRouting();

app.UseAuthorization();
app.UseStaticFiles();// Critical for serving static assets from the wwwroot folder in your project. This is required for Razor Pages to work correctly.
//app.MapStaticAssets();
app.MapRazorPages();//.WithStaticAssets();

app.Run();
