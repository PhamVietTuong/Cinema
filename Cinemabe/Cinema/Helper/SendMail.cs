using System;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

public class SendMail
{
    private readonly string _smtpServer;
    private readonly string _smtpUser;
    private readonly string _smtpPass;

    //username and password: ckccinema@gmail.com | 0203ckccinema
    public SendMail(string smtpPass = "ngos xncu ntiz anyp", string smtpUser = "ckccinema@gmail.com", string smtpServer = "smtp.gmail.com")
    {
        _smtpServer = smtpServer;
        _smtpUser = smtpUser;
        _smtpPass = smtpPass;
    }

    public async Task<bool> SendEmailAsync(string toEmail, string subject, dynamic body)
    {
        try
        {
            var smtpClient = new SmtpClient(_smtpServer)
            {
                Port = 587,
                Credentials = new NetworkCredential(_smtpUser, _smtpPass),
                EnableSsl = true, // Sử dụng STARTTLS
            };

            var mailMessage = new MailMessage
            {
                From = new MailAddress(_smtpUser),
                Subject = subject,
                Body = body,
                IsBodyHtml = true,
            };

            mailMessage.To.Add(toEmail);

            await smtpClient.SendMailAsync(mailMessage);
            Console.WriteLine("Email sent successfully.");
            return true;
        }
        catch (SmtpException smtpEx)
        {
            Console.WriteLine($"SMTP error: {smtpEx.Message}");
            Console.WriteLine($"StatusCode: {smtpEx.StatusCode}");
            if (smtpEx.InnerException != null)
            {
                Console.WriteLine($"Inner exception: {smtpEx.InnerException.Message}");
            }
            return false;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Gửi email thất bại: {ex.Message}");
            if (ex.InnerException != null)
            {
                Console.WriteLine($"Inner exception: {ex.InnerException.Message}");
            }
            return false;
        }
    }
}
