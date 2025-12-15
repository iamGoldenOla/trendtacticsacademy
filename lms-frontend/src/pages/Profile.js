import React, { useState, useEffect } from "react";
import axios from "axios";

const paymentGateways = [
    {
        name: 'Paystack',
        logo: '/payments/paystack.png',
        url: 'https://paystack.com/pay/your-link'
    },
    {
        name: 'Flutterwave',
        logo: '/payments/flutterwave.png',
        url: 'https://flutterwave.com/pay/your-link'
    },
    {
        name: 'Stripe',
        logo: '/payments/stripe.png',
        url: 'https://buy.stripe.com/your-link'
    },
    {
        name: 'Mastercard',
        logo: 'https://upload.wikimedia.org/wikipedia/commons/0/04/Mastercard-logo.png',
        url: '#'
    }
];

const mockInvoices = [
    { id: 'INV-001', company: 'Trendtactics Academy', issuer: 'Admin', date: '2024-07-01', amount: 5000, status: 'Paid', downloadUrl: '#' },
    { id: 'INV-002', company: 'Trendtactics Academy', issuer: 'Admin', date: '2024-07-10', amount: 12000, status: 'Pending', downloadUrl: '#' }
];

const Profile = ({ user }) => {
    const [isEditing, setIsEditing] = useState(false);
    const [form, setForm] = useState({
        name: user?.name || '',
        email: user?.email || '',
        username: '',
        phone: '',
        address: '',
    });
    const [invoices, setInvoices] = useState(mockInvoices);
    const [newInvoice, setNewInvoice] = useState({ company: '', issuer: '', date: '', amount: '', status: 'Pending' });
    const [showMastercardForm, setShowMastercardForm] = useState(false);
    const [mastercardDetails, setMastercardDetails] = useState({ number: '', name: '', expiry: '', cvv: '' });
    
    // Social Links state and handlers
    const [socialLinks, setSocialLinks] = useState({
        linkedin: user?.socialLinks?.linkedin || '',
        github: user?.socialLinks?.github || '',
        facebook: user?.socialLinks?.facebook || '',
        instagram: user?.socialLinks?.instagram || '',
        website: user?.socialLinks?.website || ''
    });
    
    const [notificationsEnabled, setNotificationsEnabled] = useState(false);
    const [darkModeEnabled, setDarkModeEnabled] = useState(false);
    
    const handleToggleNotifications = () => setNotificationsEnabled((prev) => !prev);
    const handleToggleDarkMode = () => setDarkModeEnabled((prev) => !prev);
    const handleEnable2FA = () => alert('2FA enabled (mock)!');

    const handleSocialChange = (e) => {
        setSocialLinks({
            ...socialLinks,
            [e.target.name]: e.target.value
        });
    };

    const handleSaveSocialLinks = async () => {
        try {
            await axios.put('/api/auth/profile', { socialLinks }, { withCredentials: true });
            alert('Social links saved!');
        } catch (err) {
            alert('Failed to save social links.');
        }
    };

    const handleChange = (e) => {
        setForm({
            ...form,
            [e.target.name]: e.target.value
        });
    };

    const handleEdit = () => setIsEditing(true);
    const handleCancel = () => setIsEditing(false);

    const handleSave = () => {
        // Save logic here
        setIsEditing(false);
    };

    const handleInvoiceChange = (e) => {
        setNewInvoice({
            ...newInvoice,
            [e.target.name]: e.target.value
        });
    };

    const handleAddInvoice = (e) => {
        e.preventDefault();
        if (!newInvoice.company || !newInvoice.issuer || !newInvoice.date || !newInvoice.amount) return;
        
        setInvoices([
            ...invoices,
            {
                id: `INV-${invoices.length + 1}`,
                company: newInvoice.company,
                issuer: newInvoice.issuer,
                date: newInvoice.date,
                amount: Number(newInvoice.amount),
                status: newInvoice.status,
                downloadUrl: '#'
            }
        ]);
        
        setNewInvoice({ company: '', issuer: '', date: '', amount: '', status: 'Pending' });
    };

    if (!user) {
        return <div className="p-8 text-center text-lg">You are not logged in.</div>;
    }

    return (
        <div className="max-w-5xl mx-auto py-10 px-4">
            <h1 className="text-3xl font-bold mb-8 text-center">Profile</h1>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {/* Profile Picture */}
                <div className="col-span-1 bg-white rounded-2xl shadow-lg p-6 flex flex-col items-center bento-card">
                    <div className="w-24 h-24 rounded-full bg-gray-200 flex items-center justify-center text-4xl mb-4">
                        <span role="img" aria-label="avatar">👤</span>
                    </div>
                    <button className="mt-2 px-4 py-1 rounded bg-indigo-600 text-white text-sm hover:bg-indigo-700">Change</button>
                </div>
                
                {/* Basic Info & Contact */}
                <div className="col-span-2 grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div className="bg-white rounded-2xl shadow-lg p-6 bento-card relative">
                        <div className="flex justify-between items-center mb-2">
                            <h2 className="text-xl font-semibold">Basic Information</h2>
                            {!isEditing && <button className="text-indigo-600 hover:underline text-sm" onClick={handleEdit}>Edit</button>}
                        </div>
                        {isEditing ? (
                            <form className="space-y-2">
                                <input 
                                    name="name" 
                                    value={form.name} 
                                    onChange={handleChange} 
                                    className="w-full border rounded px-3 py-2 mb-2" 
                                    placeholder="Name"
                                />
                                <input 
                                    name="email" 
                                    value={form.email} 
                                    onChange={handleChange} 
                                    className="w-full border rounded px-3 py-2 mb-2" 
                                    placeholder="Email"
                                />
                                <input 
                                    name="username" 
                                    value={form.username} 
                                    onChange={handleChange} 
                                    className="w-full border rounded px-3 py-2 mb-2" 
                                    placeholder="Username"
                                />
                                <div className="flex gap-2 mt-2">
                                    <button 
                                        type="button" 
                                        className="px-4 py-1 bg-indigo-600 text-white rounded hover:bg-indigo-700" 
                                        onClick={handleSave}
                                    >
                                        Save
                                    </button>
                                    <button 
                                        type="button" 
                                        className="px-4 py-1 bg-gray-300 text-gray-700 rounded hover:bg-gray-400" 
                                        onClick={handleCancel}
                                    >
                                        Cancel
                                    </button>
                                </div>
                            </form>
                        ) : (
                            <div>
                                <p><span className="font-medium">Name:</span> {form.name}</p>
                                <p><span className="font-medium">Email:</span> {form.email}</p>
                                <p><span className="font-medium">Username:</span> {form.username || <span className="italic text-gray-400">-</span>}</p>
                                <p><span className="font-medium">Role:</span> {user.role}</p>
                            </div>
                        )}
                    </div>
                    
                    <div className="bg-white rounded-2xl shadow-lg p-6 bento-card">
                        <h2 className="text-xl font-semibold mb-2">Contact Information</h2>
                        <input 
                            name="phone" 
                            value={form.phone} 
                            onChange={handleChange} 
                            className="w-full border rounded px-3 py-2 mb-2" 
                            placeholder="Phone"
                        />
                        <input 
                            name="address" 
                            value={form.address} 
                            onChange={handleChange} 
                            className="w-full border rounded px-3 py-2" 
                            placeholder="Address"
                        />
                    </div>
                </div>
                
                {/* Password Management */}
                <div className="col-span-1 bg-white rounded-2xl shadow-lg p-6 bento-card">
                    <h2 className="text-xl font-semibold mb-2">Password Management</h2>
                    <input 
                        type="password" 
                        className="w-full border rounded px-3 py-2 mb-2" 
                        placeholder="New Password"
                    />
                    <button className="px-4 py-1 bg-indigo-600 text-white rounded hover:bg-indigo-700">Change Password</button>
                </div>
                
                {/* Course Progress */}
                <div className="col-span-2 bg-white rounded-2xl shadow-lg p-6 bento-card">
                    <h2 className="text-xl font-semibold mb-2">Course Progress</h2>
                    <div className="w-full bg-gray-200 rounded-full h-3 mb-2">
                        <div 
                            className="bg-indigo-500 h-3 rounded-full transition-all duration-300" 
                            style={{ width: '60%' }}
                        ></div>
                    </div>
                    <div className="text-right text-sm text-gray-600">60% complete</div>
                </div>
                
                {/* Account Settings & Edit Profile */}
                <div className="col-span-3 bg-white rounded-2xl shadow-lg p-6 bento-card">
                    <h2 className="text-xl font-semibold mb-4">Account Settings</h2>
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div className="border rounded-lg p-4">
                            <h3 className="font-medium mb-2">Notifications</h3>
                            <label className="flex items-center cursor-pointer">
                                <div className="relative">
                                    <input 
                                        type="checkbox" 
                                        className="sr-only" 
                                        checked={notificationsEnabled}
                                        onChange={handleToggleNotifications}
                                    />
                                    <div className={`block w-10 h-6 rounded-full ${notificationsEnabled ? 'bg-indigo-600' : 'bg-gray-300'}`}></div>
                                    <div className={`absolute left-1 top-1 bg-white w-4 h-4 rounded-full transition-transform ${notificationsEnabled ? 'transform translate-x-4' : ''}`}></div>
                                </div>
                                <div className="ml-3 text-gray-700">Enable Notifications</div>
                            </label>
                        </div>
                        
                        <div className="border rounded-lg p-4">
                            <h3 className="font-medium mb-2">Dark Mode</h3>
                            <label className="flex items-center cursor-pointer">
                                <div className="relative">
                                    <input 
                                        type="checkbox" 
                                        className="sr-only" 
                                        checked={darkModeEnabled}
                                        onChange={handleToggleDarkMode}
                                    />
                                    <div className={`block w-10 h-6 rounded-full ${darkModeEnabled ? 'bg-indigo-600' : 'bg-gray-300'}`}></div>
                                    <div className={`absolute left-1 top-1 bg-white w-4 h-4 rounded-full transition-transform ${darkModeEnabled ? 'transform translate-x-4' : ''}`}></div>
                                </div>
                                <div className="ml-3 text-gray-700">Enable Dark Mode</div>
                            </label>
                        </div>
                        
                        <div className="border rounded-lg p-4">
                            <h3 className="font-medium mb-2">Two-Factor Authentication</h3>
                            <button 
                                className="px-4 py-1 bg-indigo-600 text-white rounded hover:bg-indigo-700"
                                onClick={handleEnable2FA}
                            >
                                Enable 2FA
                            </button>
                        </div>
                    </div>
                </div>
                
                {/* Social Links */}
                <div className="col-span-3 bg-white rounded-2xl shadow-lg p-6 bento-card">
                    <h2 className="text-xl font-semibold mb-4">Social Links</h2>
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <input 
                            name="linkedin" 
                            value={socialLinks.linkedin} 
                            onChange={handleSocialChange} 
                            className="w-full border rounded px-3 py-2" 
                            placeholder="LinkedIn Profile URL"
                        />
                        <input 
                            name="github" 
                            value={socialLinks.github} 
                            onChange={handleSocialChange} 
                            className="w-full border rounded px-3 py-2" 
                            placeholder="GitHub Profile URL"
                        />
                        <input 
                            name="facebook" 
                            value={socialLinks.facebook} 
                            onChange={handleSocialChange} 
                            className="w-full border rounded px-3 py-2" 
                            placeholder="Facebook Profile URL"
                        />
                        <input 
                            name="instagram" 
                            value={socialLinks.instagram} 
                            onChange={handleSocialChange} 
                            className="w-full border rounded px-3 py-2" 
                            placeholder="Instagram Profile URL"
                        />
                        <input 
                            name="website" 
                            value={socialLinks.website} 
                            onChange={handleSocialChange} 
                            className="w-full border rounded px-3 py-2 md:col-span-2" 
                            placeholder="Personal Website URL"
                        />
                    </div>
                    <button 
                        className="mt-4 px-4 py-1 bg-indigo-600 text-white rounded hover:bg-indigo-700"
                        onClick={handleSaveSocialLinks}
                    >
                        Save Social Links
                    </button>
                </div>
                
                {/* Payment Methods */}
                <div className="col-span-3 bg-white rounded-2xl shadow-lg p-6 bento-card">
                    <h2 className="text-xl font-semibold mb-4">Payment Methods</h2>
                    <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                        {paymentGateways.map((gateway) => (
                            <div key={gateway.name} className="border rounded-lg p-4 flex flex-col items-center">
                                <img src={gateway.logo} alt={gateway.name} className="h-8 mb-2" />
                                <a 
                                    href={gateway.url} 
                                    className="mt-2 px-3 py-1 bg-indigo-600 text-white text-sm rounded hover:bg-indigo-700"
                                    target="_blank" 
                                    rel="noopener noreferrer"
                                >
                                    Connect
                                </a>
                            </div>
                        ))}
                    </div>
                </div>
                
                {/* Invoices */}
                <div className="col-span-3 bg-white rounded-2xl shadow-lg p-6 bento-card">
                    <h2 className="text-xl font-semibold mb-4">Invoices</h2>
                    <div className="overflow-x-auto">
                        <table className="min-w-full divide-y divide-gray-200">
                            <thead className="bg-gray-50">
                                <tr>
                                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Invoice ID</th>
                                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Company</th>
                                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Issuer</th>
                                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Action</th>
                                </tr>
                            </thead>
                            <tbody className="bg-white divide-y divide-gray-200">
                                {invoices.map((inv) => (
                                    <tr key={inv.id}>
                                        <td className="px-6 py-4 whitespace-nowrap">{inv.id}</td>
                                        <td className="px-6 py-4 whitespace-nowrap">{inv.company}</td>
                                        <td className="px-6 py-4 whitespace-nowrap">{inv.issuer || '-'}</td>
                                        <td className="px-6 py-4 whitespace-nowrap">{inv.date}</td>
                                        <td className="px-6 py-4 whitespace-nowrap">₦{inv.amount.toLocaleString()}</td>
                                        <td className="px-6 py-4 whitespace-nowrap">
                                            <span className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${
                                                inv.status === 'Paid' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'
                                            }`}>
                                                {inv.status}
                                            </span>
                                        </td>
                                        <td className="px-6 py-4 whitespace-nowrap">
                                            <a href={inv.downloadUrl} className="text-indigo-600 hover:underline">Download</a>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                    
                    {/* Add Invoice Form */}
                    <div className="mt-6 p-4 border rounded-lg">
                        <h3 className="text-lg font-medium mb-3">Add New Invoice</h3>
                        <form onSubmit={handleAddInvoice} className="grid grid-cols-1 md:grid-cols-5 gap-3">
                            <input 
                                name="company" 
                                value={newInvoice.company} 
                                onChange={handleInvoiceChange} 
                                className="border rounded px-3 py-2" 
                                placeholder="Company"
                                required
                            />
                            <input 
                                name="issuer" 
                                value={newInvoice.issuer} 
                                onChange={handleInvoiceChange} 
                                className="border rounded px-3 py-2" 
                                placeholder="Issuer"
                                required
                            />
                            <input 
                                name="date" 
                                value={newInvoice.date} 
                                onChange={handleInvoiceChange} 
                                className="border rounded px-3 py-2" 
                                placeholder="Date (YYYY-MM-DD)"
                                required
                            />
                            <input 
                                name="amount" 
                                value={newInvoice.amount} 
                                onChange={handleInvoiceChange} 
                                className="border rounded px-3 py-2" 
                                placeholder="Amount"
                                type="number"
                                required
                            />
                            <select 
                                name="status" 
                                value={newInvoice.status} 
                                onChange={handleInvoiceChange} 
                                className="border rounded px-3 py-2"
                            >
                                <option value="Pending">Pending</option>
                                <option value="Paid">Paid</option>
                            </select>
                            <button 
                                type="submit" 
                                className="md:col-span-5 px-4 py-2 bg-indigo-600 text-white rounded hover:bg-indigo-700"
                            >
                                Add Invoice
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Profile;