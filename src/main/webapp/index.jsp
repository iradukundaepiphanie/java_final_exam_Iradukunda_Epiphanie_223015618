<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>University of Rwanda - Education Platform</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0D47A1 0%, #1976D2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        /* Header */
        .header {
            background: rgba(255, 255, 255, 0.98);
            padding: 20px 0;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 30px;
        }
        
        .logo-section {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .logo {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #0D47A1, #1976D2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #FBC02D;
            font-size: 32px;
            font-weight: 700;
            box-shadow: 0 4px 15px rgba(13, 71, 161, 0.3);
        }
        
        .university-info h1 {
            color: #0D47A1;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .university-info p {
            color: #666;
            font-size: 14px;
        }
        
        .login-btn-header {
            background: linear-gradient(135deg, #0D47A1, #1976D2);
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(13, 71, 161, 0.3);
        }
        
        .login-btn-header:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(13, 71, 161, 0.4);
        }
        
        /* Hero Section */
        .hero {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 60px 30px;
        }
        
        .hero-content {
            max-width: 1200px;
            width: 100%;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
        }
        
        .hero-text {
            color: white;
        }
        
        .hero-text h2 {
            font-size: 48px;
            margin-bottom: 20px;
            line-height: 1.2;
        }
        
        .hero-text .highlight {
            color: #FBC02D;
        }
        
        .hero-text p {
            font-size: 18px;
            line-height: 1.8;
            margin-bottom: 35px;
            opacity: 0.95;
        }
        
        .cta-buttons {
            display: flex;
            gap: 20px;
        }
        
        .btn-primary {
            background: #FBC02D;
            color: #0D47A1;
            padding: 16px 40px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 700;
            font-size: 18px;
            transition: all 0.3s;
            box-shadow: 0 6px 25px rgba(251, 192, 45, 0.4);
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 35px rgba(251, 192, 45, 0.5);
        }
        
        .btn-secondary {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 16px 40px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            font-size: 18px;
            transition: all 0.3s;
            border: 2px solid rgba(255, 255, 255, 0.5);
        }
        
        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.3);
            border-color: white;
        }
        
        /* Features */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
        }
        
        .feature-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            padding: 25px;
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s;
        }
        
        .feature-card:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-5px);
        }
        
        .feature-card i {
            font-size: 36px;
            color: #FBC02D;
            margin-bottom: 15px;
        }
        
        .feature-card h3 {
            color: white;
            margin-bottom: 10px;
            font-size: 18px;
        }
        
        .feature-card p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 14px;
            line-height: 1.6;
        }
        
        /* Footer */
        .footer {
            background: rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
            padding: 40px 0 20px;
            color: white;
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 30px;
        }
        
        .footer-grid {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 40px;
            margin-bottom: 30px;
        }
        
        .footer-section h3 {
            color: #FBC02D;
            margin-bottom: 20px;
            font-size: 18px;
        }
        
        .footer-section p {
            line-height: 1.8;
            opacity: 0.9;
            margin-bottom: 15px;
        }
        
        .footer-section ul {
            list-style: none;
        }
        
        .footer-section ul li {
            margin-bottom: 12px;
        }
        
        .footer-section ul li a {
            color: white;
            text-decoration: none;
            opacity: 0.9;
            transition: all 0.3s;
        }
        
        .footer-section ul li a:hover {
            opacity: 1;
            color: #FBC02D;
            padding-left: 5px;
        }
        
        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 15px;
        }
        
        .social-links a {
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            transition: all 0.3s;
        }
        
        .social-links a:hover {
            background: #FBC02D;
            color: #0D47A1;
            transform: translateY(-3px);
        }
        
        .footer-bottom {
            text-align: center;
            padding-top: 25px;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
            opacity: 0.8;
        }
        
        @media (max-width: 968px) {
            .hero-content {
                grid-template-columns: 1fr;
                text-align: center;
            }
            
            .footer-grid {
                grid-template-columns: 1fr;
            }
            
            .cta-buttons {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="header-content">
            <div class="logo-section">
                <div class="logo">UR</div>
                <div class="university-info">
                    <h1>University of Rwanda</h1>
                    <p>Education Monitoring Platform</p>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/login" class="login-btn-header">
                <i class="fas fa-sign-in-alt"></i> Login
            </a>
        </div>
    </div>
    
    <!-- Hero Section -->
    <div class="hero">
        <div class="hero-content">
            <div class="hero-text">
                <h2>Welcome to the <span class="highlight">Future</span> of Education</h2>
                <p>
                    Experience a seamless learning management system designed for students, 
                    instructors, and administrators. Track progress, manage courses, and 
                    achieve academic excellence with our comprehensive platform.
                </p>
                <div class="cta-buttons">
                    <a href="${pageContext.request.contextPath}/login" class="btn-primary">
                        <i class="fas fa-rocket"></i> Get Started
                    </a>
                    <a href="#features" class="btn-secondary">
                        <i class="fas fa-info-circle"></i> Learn More
                    </a>
                </div>
            </div>
            
            <div class="features-grid" id="features">
                <div class="feature-card">
                    <i class="fas fa-graduation-cap"></i>
                    <h3>For Students</h3>
                    <p>Access courses, submit assignments, view grades, and track your academic progress in real-time.</p>
                </div>
                
                <div class="feature-card">
                    <i class="fas fa-chalkboard-teacher"></i>
                    <h3>For Instructors</h3>
                    <p>Manage courses, create assignments, grade submissions, and monitor student performance.</p>
                </div>
                
                <div class="feature-card">
                    <i class="fas fa-tasks"></i>
                    <h3>Smart Assignments</h3>
                    <p>Auto-graded MCQ quizzes, timed assessments, and essay submissions with instant feedback.</p>
                </div>
                
                <div class="feature-card">
                    <i class="fas fa-chart-line"></i>
                    <h3>Analytics & Reports</h3>
                    <p>Comprehensive dashboards with insights, trends, and detailed academic reports.</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <div class="footer">
        <div class="footer-content">
            <div class="footer-grid">
                <div class="footer-section">
                    <h3>University of Rwanda</h3>
                    <p>
                        Leading the way in higher education across Rwanda, committed to 
                        academic excellence, research, and innovation.
                    </p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
                
                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/login">Student Login</a></li>
                        <li><a href="${pageContext.request.contextPath}/login">Instructor Login</a></li>
                        <li><a href="${pageContext.request.contextPath}/login">Admin Portal</a></li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3>Support</h3>
                    <ul>
                        <li><a href="#">Help Center</a></li>
                        <li><a href="#">Documentation</a></li>
                        <li><a href="#">Contact Us</a></li>
                        <li><a href="#">FAQs</a></li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3>Contact</h3>
                    <ul>
                        <li><i class="fas fa-envelope"></i> info@ur.ac.rw</li>
                        <li><i class="fas fa-phone"></i> +250 788 000 000</li>
                        <li><i class="fas fa-map-marker-alt"></i> Kigali, Rwanda</li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2025 University of Rwanda. All rights reserved.fina. | Education Platform v1.0</p>
            </div>
        </div>
    </div>
</body>
</html>
