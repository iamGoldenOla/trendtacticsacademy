-- FACEBOOK ADS FOUNDATION - LESSONS 3-6
-- Comprehensive content with proper SQL escaping

DO $$
DECLARE
    foundation_id UUID;
    mod1_id UUID;
    lesson_id UUID;
BEGIN
    SELECT id INTO foundation_id FROM courses WHERE title = 'Facebook Ads Foundation';
    SELECT id INTO mod1_id FROM modules WHERE course_id = foundation_id AND ordering = 1;
    
    RAISE NOTICE 'Creating Lessons 3-6...';
    
    -- =====================================================
    -- LESSON 3: Setting Up a Business Manager Account
    -- =====================================================
    INSERT INTO lessons (module_id, title, ordering, content, duration, video_url)
    VALUES (
        mod1_id,
        'Setting Up a Business Manager Account',
        3,
        '<div class="lesson-content">

<h2>Learning Objectives</h2>
<ul>
<li>Understand what Facebook Business Manager is and why it''s essential</li>
<li>Learn how to create and configure a Business Manager account</li>
<li>Master the process of adding assets (Pages, Ad Accounts, Pixels)</li>
<li>Understand user roles and permissions management</li>
<li>Set up your account for optimal security and organization</li>
</ul>

<h2>What is Facebook Business Manager?</h2>

<p>Facebook Business Manager is a centralized platform that allows you to manage multiple Facebook Pages, ad accounts, and team members in one place. Think of it as the command center for your Facebook marketing operations. Whether you''re managing ads for your own business or handling multiple clients as an agency, Business Manager provides the organizational structure and security features necessary for professional advertising at scale.</p>

<p>The platform separates your personal Facebook profile from your business activities, which is crucial for maintaining professionalism and security. When you use Business Manager, your personal information remains private, and you can grant team members access to business assets without sharing passwords or personal account access. This separation also protects your business if an employee leaves or if your personal account is compromised.</p>

<h2>Why Business Manager is Essential</h2>

<p>Running ads directly from a Facebook Page might seem simpler initially, but it creates significant limitations and risks as your business grows. Without Business Manager, you cannot properly separate business and personal activities, manage team permissions effectively, or maintain control over your advertising assets. If you ever need to transfer ad accounts, add partners, or scale your operations, you will find these tasks nearly impossible without Business Manager.</p>

<p>Business Manager becomes absolutely essential when working with agencies, freelancers, or team members. It allows you to grant specific permissions to different people without giving them full access to everything. For example, you can allow a freelancer to create ads without giving them the ability to view your billing information or delete your ad accounts. This granular control over permissions is impossible when running ads directly from a Page.</p>

<h2>Step-by-Step Setup Process</h2>

<p>Creating a Business Manager account is straightforward, but doing it correctly from the start saves headaches later. Begin by visiting business.facebook.com and clicking "Create Account." You will need to provide your business name, your name, and your business email address. Use your actual business email, not a personal email, as this will be the primary contact for important notifications and security alerts.</p>

<p>After creating your account, the first critical step is adding your Facebook Page. Navigate to Business Settings, click on Pages, and then Add. You can either add an existing Page that you manage or create a new one. If you''re adding an existing Page, you must be an admin of that Page. Once added, the Page becomes an asset of your Business Manager, and you can assign different people various levels of access to it.</p>

<p>Next, create or add an ad account. Go to Business Settings, select Ad Accounts, and click Add. You can create a new ad account, request access to an existing one, or add an ad account you already own. Each Business Manager can have multiple ad accounts, which is useful if you''re managing different brands or want to separate testing budgets from main campaign budgets. Set your ad account''s currency and time zone carefully during creation, as these cannot be changed later.</p>

<h2>Understanding User Roles and Permissions</h2>

<p>Business Manager offers several permission levels for different assets. For Pages, you can assign people as Admin, Editor, Moderator, Advertiser, or Analyst. Each role has specific capabilities. Admins have full control, Editors can create and publish content, Moderators can respond to comments, Advertisers can create ads, and Analysts can only view insights. Choose roles carefully based on what each team member actually needs to do.</p>

<p>For ad accounts, the main roles are Admin and Advertiser. Ad Account Admins can manage all aspects of the ad account including adding other people and viewing billing information. Advertisers can create and manage ads but cannot access billing or add other users. This distinction is crucial when working with freelancers or agencies - you typically want to give them Advertiser access, not Admin access.</p>

<h2>Security Best Practices</h2>

<p>Enable two-factor authentication immediately after creating your Business Manager. This adds an extra layer of security by requiring a code from your phone in addition to your password when logging in. Given that your Business Manager controls potentially significant advertising budgets, this security measure is not optional - it is essential. Navigate to Security Center in Business Settings to enable two-factor authentication.</p>

<p>Regularly audit who has access to your Business Manager and what permissions they have. People change roles, freelancers complete projects, and employees leave companies. Make it a monthly practice to review the People section in Business Settings and remove access for anyone who no longer needs it. This simple habit prevents security breaches and unauthorized spending.</p>

<h2>Real-World Case Study: Agency Setup Success</h2>

<p>A digital marketing agency in Lagos was managing Facebook ads for 15 clients using personal ad accounts and shared passwords. This created chaos - they could not track which team member made which changes, clients had access to other clients'' information, and when an employee left, they had to change passwords across dozens of accounts.</p>

<p>They restructured everything using Business Manager. They created one Business Manager for their agency and requested access to each client''s ad account rather than running ads from their own accounts. They set up proper permissions so junior team members could create ads but not access billing, while senior strategists had full admin access. They implemented two-factor authentication across all accounts.</p>

<p>The results were transformative. They reduced time spent on account management by 60%. Security incidents dropped to zero. Client satisfaction increased because clients could see exactly who was accessing their accounts and what changes were being made. When team members left, they simply removed their access from Business Manager rather than scrambling to change passwords. The agency scaled from 15 to 40 clients within six months because their systems could handle the growth.</p>

<h2>Comprehensive Summary</h2>

<p>Facebook Business Manager is not just a convenience - it is the foundation of professional Facebook advertising. The platform provides the organizational structure, security features, and permission controls necessary to manage advertising operations effectively, whether you are running ads for a single business or managing dozens of clients. Setting it up correctly from the beginning prevents countless headaches and security issues down the road.</p>

<p>The separation between personal and business activities that Business Manager provides is crucial for both professionalism and security. Your personal Facebook activity remains private, your business assets are protected even if your personal account is compromised, and you can manage team access without sharing passwords or personal information. This separation becomes more valuable as your business grows and more people need access to your advertising assets.</p>

<p>Proper permission management through Business Manager allows you to give team members exactly the access they need - nothing more, nothing less. This granular control is impossible when running ads directly from a Page or personal account. Whether you are working with freelancers, agencies, or internal team members, Business Manager''s permission system ensures everyone can do their job while maintaining security and control over your assets.</p>

<p>Security features like two-factor authentication and activity logs make Business Manager essential for protecting your advertising investment. With potentially thousands or millions of Naira flowing through your ad accounts, the security measures Business Manager provides are not optional extras - they are fundamental requirements. Regular audits of user access and permissions should be part of your standard operating procedures.</p>

<p>The initial setup of Business Manager might seem like extra work compared to simply running ads from a Page, but this upfront investment pays dividends immediately and compounds over time. As your advertising operations grow, your Business Manager grows with you, providing the infrastructure needed to scale effectively. Every successful Facebook advertiser and agency uses Business Manager - it is simply the professional standard for managing Facebook advertising.</p>

</div>',
        25,
        'https://www.youtube.com/watch?v=2xfMQDxaG_w'
    )
    RETURNING id INTO lesson_id;
    
    -- Quiz for Lesson 3
    INSERT INTO quiz_questions (lesson_id, question, options, correct_answer, explanation)
    VALUES
    (lesson_id,
     'What is the primary purpose of Facebook Business Manager?',
     '["Centralized management of Pages, ad accounts, and team members", "Creating Facebook ads faster", "Getting lower ad costs", "Posting to multiple Pages simultaneously"]'::jsonb,
     0,
     'Business Manager provides centralized control over all business assets and team permissions'),
    
    (lesson_id,
     'Why is it important to separate personal and business Facebook activities?',
     '["For security and professionalism", "To get better ad performance", "Facebook requires it", "To access special features"]'::jsonb,
     0,
     'Separation protects personal privacy and business assets from being compromised together'),
    
    (lesson_id,
     'What cannot be changed after creating an ad account?',
     '["Currency and time zone", "Ad account name", "Payment method", "Team members"]'::jsonb,
     0,
     'Currency and time zone are permanent settings that cannot be modified after account creation'),
    
    (lesson_id,
     'What is the difference between Admin and Advertiser roles for ad accounts?',
     '["Admins can access billing and add users, Advertisers cannot", "Admins can create better ads", "Advertisers have limited budget access", "No significant difference"]'::jsonb,
     0,
     'Admin role includes billing access and user management, while Advertiser role is limited to creating and managing ads'),
    
    (lesson_id,
     'Why is two-factor authentication essential for Business Manager?',
     '["Protects accounts controlling significant advertising budgets", "Required by Facebook", "Improves ad performance", "Allows more team members"]'::jsonb,
     0,
     'Two-factor authentication provides critical security for accounts that may control large advertising budgets');
    
    RAISE NOTICE 'Lesson 3 created with 5 quizzes';
    
END $$;

-- Verify
SELECT 
    l.ordering,
    l.title,
    LENGTH(l.content) as content_chars,
    (SELECT COUNT(*) FROM quiz_questions WHERE lesson_id = l.id) as quiz_count
FROM lessons l
JOIN modules m ON l.module_id = m.id
JOIN courses c ON m.course_id = c.id
WHERE c.title = 'Facebook Ads Foundation' AND m.ordering = 1
ORDER BY l.ordering;
