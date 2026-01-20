-- Update Videos for Facebook Ads Foundation Course
-- Course ID: a1b2c3d4-e5f6-7890-1234-567890abcdef

-- Helper function to update video by lesson title pattern
CREATE OR REPLACE FUNCTION update_fb_foundation_video(lesson_title_pattern TEXT, video_id TEXT) RETURNS VOID AS $$
BEGIN
    UPDATE lessons
    SET video_url = 'https://www.youtube.com/embed/' || video_id
    FROM modules
    WHERE lessons.module_id = modules.id
      AND modules.course_id = 'a1b2c3d4-e5f6-7890-1234-567890abcdef'
      AND lessons.title ILIKE '%' || lesson_title_pattern || '%';
END;
$$ LANGUAGE plpgsql;

-- Module 1
SELECT update_fb_foundation_video('Meta Ads Manager Simulator', '8rABwKRsec4');
SELECT update_fb_foundation_video('What Are Facebook Ads', '006V3t__xkc');
SELECT update_fb_foundation_video('Setting Up a Business Manager', 'JXhQyYwYw5k');
SELECT update_fb_foundation_video('Understanding the Facebook Ads Ecosystem', 'smIMGQbvVDY');
SELECT update_fb_foundation_video('Navigating Meta Ads Manager', 'qaZC3XSAeR8');
SELECT update_fb_foundation_video('Key Terminology', 'R9JNM36iPug');

-- Module 2
SELECT update_fb_foundation_video('Types of Audiences', 'dwVLcMTRNHI');
SELECT update_fb_foundation_video('Building Buyer Personas', 'lpQugp7AXEU');
SELECT update_fb_foundation_video('Geo, Demographic & Behavioral', 'F8Bu8tgWHyc');
SELECT update_fb_foundation_video('Retargeting Strategies', 'TPnqxl82Rw4');
SELECT update_fb_foundation_video('Audience Layering', 'wPlAalud2Hg');

-- Module 3
SELECT update_fb_foundation_video('Choosing the Right Campaign', 'DaON4AlfGR8');
SELECT update_fb_foundation_video('Awareness vs. Consideration', 'nlVuhml4R6E');
SELECT update_fb_foundation_video('Funnel Mapping', '-jw5Uu2LaQQ');
SELECT update_fb_foundation_video('Budgeting: Daily', 'wKDeZWnVA9c');
SELECT update_fb_foundation_video('Bidding Strategies', 'b_6jaNayDag');

-- Module 4
SELECT update_fb_foundation_video('Ad Formats', 'HzAGUY9zHSw');
SELECT update_fb_foundation_video('Writing High-Converting', 'Jlum3q1aRes');
SELECT update_fb_foundation_video('Visual Psychology', 'LMh-BAJtbFE');
SELECT update_fb_foundation_video('A/B Testing Creatives', 'MaNKao9jYwI');
SELECT update_fb_foundation_video('Dynamic Creative Optimization', 'KtQzxXQMkpo');

-- Module 5
SELECT update_fb_foundation_video('Installing the Facebook Pixel', 'cBs_6DyovXc');
SELECT update_fb_foundation_video('Standard vs. Custom Events', '7Q17ubqLfaM');
SELECT update_fb_foundation_video('Conversion Tracking', 'CA3f0vJTv28');
SELECT update_fb_foundation_video('Offline Conversions', 'sd-zrXdBRTU');
SELECT update_fb_foundation_video('Troubleshooting Pixel', 'YXNaN7SdEzc');

-- Module 6
SELECT update_fb_foundation_video('Reading Performance Data', 'QfGZkQ4X4mU');
SELECT update_fb_foundation_video('KPIs That Matter', 'OwT_Knp4xB8');
SELECT update_fb_foundation_video('Scaling Strategies', 'wPlAalud2Hg');
SELECT update_fb_foundation_video('Techniques: CBO', 'DaON4AlfGR8');
SELECT update_fb_foundation_video('Kill Underperforming Ads', 'QTckkqSyxwA');

-- Module 7
SELECT update_fb_foundation_video('Automated Rules', 'LOU7s18GMl4');
SELECT update_fb_foundation_video('Advanced Bidding', 'lmpl70E4-Mc');
SELECT update_fb_foundation_video('Retargeting with Catalogs', 'TPnqxl82Rw4');
SELECT update_fb_foundation_video('Using UTM Parameters', 'gAwZq86IzYo');
SELECT update_fb_foundation_video('Integrating Facebook Ads', 'nZQfN9JKYCM');

-- Module 8
SELECT update_fb_foundation_video('Facebook Ad Policies', '5P_MPypn4dc');
SELECT update_fb_foundation_video('Getting Unbanned', '4r4fhj14IW0');
SELECT update_fb_foundation_video('Ethical Advertising', 'mOtwkY8SxoU');
SELECT update_fb_foundation_video('Troubleshooting Disapproved', '1h_YsfL-DuU');
SELECT update_fb_foundation_video('Navigating iOS14', 'HXyEHpXxvxI');

-- Module 9
SELECT update_fb_foundation_video('E-commerce Funnel', 'Kemzu0-gVTs');
SELECT update_fb_foundation_video('Local Business Lead', 'dwVLcMTRNHI');
SELECT update_fb_foundation_video('Digital Product Launch', '4ZqbfmZju8s');
SELECT update_fb_foundation_video('Agency Client Campaign', 'h8SH5RUe5oo');
SELECT update_fb_foundation_video('Building a Portfolio', 'DvMNG6MUlGI');

-- Module 10
SELECT update_fb_foundation_video('Becoming a Facebook Ads Specialist', 'IZtkXOupVkM');
SELECT update_fb_foundation_video('Freelancing vs. Agency', 'EgHvvsDd5c0');
SELECT update_fb_foundation_video('Meta Blueprint Certification', '-W4fVKmP95Y');
SELECT update_fb_foundation_video('Building Your Personal Brand', '1IJpJIGQ32I');
SELECT update_fb_foundation_video('Landing Clients', 'Jlum3q1aRes');

-- Clean up
DROP FUNCTION update_fb_foundation_video(TEXT, TEXT);

-- Verify
SELECT id, title, video_url 
FROM lessons 
WHERE module_id IN (SELECT id FROM modules WHERE course_id = 'a1b2c3d4-e5f6-7890-1234-567890abcdef')
ORDER BY created_at ASC;
