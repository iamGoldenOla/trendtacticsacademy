import React, { useState } from 'react';
import axios from 'axios';
import { User } from '../types';

interface Invoice {
  id: string;
  company: string;
  issuer: string;
  date: string;
  amount: number;
  status: 'Paid' | 'Pending';
  downloadUrl: string;
}

interface ProfileProps {
  user: User | null;
}

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

const mockInvoices: Invoice[] = [
  { id: 'INV-001', company: 'Trendtactics Academy', issuer: 'Admin', date: '2024-07-01', amount: 5000, status: 'Paid', downloadUrl: '#' },
  { id: 'INV-002', company: 'Trendtactics Academy', issuer: 'Admin', date: '2024-07-10', amount: 12000, status: 'Pending', downloadUrl: '#' }
];

const Profile: React.FC<ProfileProps> = ({ user }) => {
  const [isEditing, setIsEditing] = useState(false);
  const [form, setForm] = useState({
    name: user?.name || '',
    email: user?.email || '',
    username: '',
    phone: '',
    address: '',
  });
  const [invoices, setInvoices] = useState<Invoice[]>(mockInvoices);
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
  const handleSocialChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSocialLinks({ ...socialLinks, [e.target.name]: e.target.value });
  };

  const handleSaveSocialLinks = async () => {
    try {
      await axios.put('/api/auth/profile', { socialLinks }, { withCredentials: true });
      alert('Social links saved!');
    } catch (err) {
      alert('Failed to save social links.');
    }
  };
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleEdit = () => setIsEditing(true);
  const handleCancel = () => setIsEditing(false);
  const handleSave = () => {
    // Save logic here
    setIsEditing(false);
  };

  const handleInvoiceChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    setNewInvoice({ ...newInvoice, [e.target.name]: e.target.value });
  };

  const handleAddInvoice = (e: React.FormEvent) => {
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
        status: newInvoice.status as 'Paid' | 'Pending',
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
                <input name="name" value={form.name} onChange={handleChange} className="w-full border rounded px-3 py-2 mb-2" placeholder="Name" />
                <input name="email" value={form.email} onChange={handleChange} className="w-full border rounded px-3 py-2 mb-2" placeholder="Email" />
                <input name="username" value={form.username} onChange={handleChange} className="w-full border rounded px-3 py-2 mb-2" placeholder="Username" />
                <div className="flex gap-2 mt-2">
                  <button type="button" className="px-4 py-1 bg-indigo-600 text-white rounded hover:bg-indigo-700" onClick={handleSave}>Save</button>
                  <button type="button" className="px-4 py-1 bg-gray-300 text-gray-700 rounded hover:bg-gray-400" onClick={handleCancel}>Cancel</button>
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
            <input name="phone" value={form.phone} onChange={handleChange} className="w-full border rounded px-3 py-2 mb-2" placeholder="Phone" />
            <input name="address" value={form.address} onChange={handleChange} className="w-full border rounded px-3 py-2" placeholder="Address" />
          </div>
        </div>
        {/* Password Management */}
        <div className="col-span-1 bg-white rounded-2xl shadow-lg p-6 bento-card">
          <h2 className="text-xl font-semibold mb-2">Password Management</h2>
          <input type="password" className="w-full border rounded px-3 py-2 mb-2" placeholder="New Password" />
          <button className="px-4 py-1 bg-indigo-600 text-white rounded hover:bg-indigo-700">Change Password</button>
        </div>
        {/* Course Progress */}
        <div className="col-span-2 bg-white rounded-2xl shadow-lg p-6 bento-card">
          <h2 className="text-xl font-semibold mb-2">Course Progress</h2>
          <div className="w-full bg-gray-200 rounded-full h-3 mb-2">
            <div className="bg-indigo-500 h-3 rounded-full transition-all duration-300" style={{ width: '60%' }}></div>
          </div>
          <div className="text-right text-sm text-gray-600">60% complete</div>
        </div>
        {/* Account Settings & Edit Profile */}
        <div className="col-span-1 bg-white rounded-2xl shadow-lg p-6 bento-card">
          <h2 className="text-xl font-semibold mb-2">Account Settings</h2>
          <label className="flex items-center gap-2 mb-2">
            <span>Notifications:</span>
            <input type="checkbox" className="toggle" checked={notificationsEnabled} onChange={handleToggleNotifications} />
          </label>
          <label className="flex items-center gap-2">
            <span>Dark Mode:</span>
            <input type="checkbox" className="toggle" checked={darkModeEnabled} onChange={handleToggleDarkMode} />
          </label>
        </div>
        <div className="col-span-1 bg-white rounded-2xl shadow-lg p-6 bento-card">
          <h2 className="text-xl font-semibold mb-2">Edit Profile</h2>
          <button className="px-4 py-1 bg-indigo-600 text-white rounded hover:bg-indigo-700" onClick={handleEdit}>Edit Details</button>
        </div>
        {/* Security & Social Links */}
        <div className="col-span-1 bg-white rounded-2xl shadow-lg p-6 bento-card">
          <h2 className="text-xl font-semibold mb-2">Security</h2>
          <button className="px-4 py-1 bg-indigo-600 text-white rounded hover:bg-indigo-700" onClick={handleEnable2FA}>Enable 2FA</button>
        </div>
        <div className="col-span-1 bg-white rounded-2xl shadow-lg p-6 bento-card">
          <h2 className="text-xl font-semibold mb-2">Social Links</h2>
          <input name="linkedin" value={socialLinks.linkedin} onChange={handleSocialChange} className="w-full border rounded px-3 py-2 mb-2" placeholder="LinkedIn URL" />
          <input name="github" value={socialLinks.github} onChange={handleSocialChange} className="w-full border rounded px-3 py-2 mb-2" placeholder="GitHub URL" />
          <input name="facebook" value={socialLinks.facebook} onChange={handleSocialChange} className="w-full border rounded px-3 py-2 mb-2" placeholder="Facebook URL" />
          <input name="instagram" value={socialLinks.instagram} onChange={handleSocialChange} className="w-full border rounded px-3 py-2 mb-2" placeholder="Instagram URL" />
          <input name="website" value={socialLinks.website} onChange={handleSocialChange} className="w-full border rounded px-3 py-2" placeholder="Website" />
          <button className="mt-3 px-4 py-1 bg-indigo-600 text-white rounded hover:bg-indigo-700 w-full" onClick={handleSaveSocialLinks}>Save Social Links</button>
        </div>
        {/* Payment Gateways & Invoices */}
        <div className="col-span-2 bg-white rounded-2xl shadow-lg p-6 bento-card">
          <h2 className="text-xl font-semibold mb-4">Payment Gateways</h2>
          <div className="flex flex-wrap gap-6">
            {paymentGateways.map((gateway) => (
              <div key={gateway.name} className="bg-white rounded-lg shadow p-4 flex flex-col items-center w-56">
                <img src={gateway.logo} alt={gateway.name} className="h-12 mb-2 object-contain" style={{maxWidth:'100%'}} />
                <div className="font-semibold mb-2 text-center">{gateway.name}</div>
                {gateway.name === 'Mastercard' ? (
                  showMastercardForm ? (
                    <form className="w-full flex flex-col gap-2" onSubmit={e => { e.preventDefault(); setShowMastercardForm(false); }}>
                      <input className="border rounded px-3 py-2" placeholder="Card Number" maxLength={19} value={mastercardDetails.number} onChange={e => setMastercardDetails({ ...mastercardDetails, number: e.target.value })} required />
                      <input className="border rounded px-3 py-2" placeholder="Cardholder Name" value={mastercardDetails.name} onChange={e => setMastercardDetails({ ...mastercardDetails, name: e.target.value })} required />
                      <div className="flex gap-2">
                        <input className="border rounded px-3 py-2 w-1/2" placeholder="MM/YY" maxLength={5} value={mastercardDetails.expiry} onChange={e => setMastercardDetails({ ...mastercardDetails, expiry: e.target.value })} required />
                        <input className="border rounded px-3 py-2 w-1/2" placeholder="CVV" maxLength={4} value={mastercardDetails.cvv} onChange={e => setMastercardDetails({ ...mastercardDetails, cvv: e.target.value })} required />
                      </div>
                      <button type="submit" className="bg-blue-600 text-white rounded px-4 py-2 mt-2 hover:bg-blue-700 transition">Pay</button>
                    </form>
                  ) : (
                    <button className="bg-blue-600 text-white rounded px-4 py-2 mt-2 hover:bg-blue-700 transition w-full" onClick={() => setShowMastercardForm(true)}>Pay with Card</button>
                  )
                ) : (
                  <a href={gateway.url} target="_blank" rel="noopener noreferrer" className="bg-blue-600 text-white rounded px-4 py-2 mt-2 hover:bg-blue-700 transition w-full text-center">{gateway.name === 'Paystack' ? 'Pay with Paystack' : gateway.name === 'Flutterwave' ? 'Pay with Flutterwave' : 'Pay Now'}</a>
                )}
              </div>
            ))}
          </div>
        </div>
        <div className="col-span-1 bg-white rounded-2xl shadow-lg p-6 bento-card overflow-x-auto">
          <h2 className="text-xl font-semibold mb-2">Invoices</h2>
          <form className="mb-4" onSubmit={handleAddInvoice}>
            <div className="flex flex-col gap-2">
              <input name="company" type="text" value={newInvoice.company || ''} onChange={handleInvoiceChange} className="border rounded px-3 py-2" placeholder="Company Name" required />
              <input name="issuer" type="text" value={newInvoice.issuer || ''} onChange={handleInvoiceChange} className="border rounded px-3 py-2" placeholder="Issuer Name" required />
              <input name="date" type="date" value={newInvoice.date} onChange={handleInvoiceChange} className="border rounded px-3 py-2" required />
              <input name="amount" type="number" value={newInvoice.amount} onChange={handleInvoiceChange} className="border rounded px-3 py-2" placeholder="Amount" required />
              <select name="status" value={newInvoice.status} onChange={handleInvoiceChange} className="border rounded px-3 py-2">
                <option value="Paid">Paid</option>
                <option value="Pending">Pending</option>
              </select>
              <button type="submit" className="px-4 py-1 bg-indigo-600 text-white rounded hover:bg-indigo-700 transition-all">Add Invoice</button>
            </div>
          </form>
          <table className="w-full text-sm table-fixed break-words">
            <thead>
              <tr>
                <th className="text-left w-20 break-words">ID</th>
                <th className="text-left w-32 break-words">Company</th>
                <th className="text-left w-32 break-words">Issuer</th>
                <th className="text-left w-24 break-words">Date</th>
                <th className="text-left w-24 break-words">Amount</th>
                <th className="text-left w-20 break-words">Status</th>
                <th className="text-left w-24 break-words">Download</th>
              </tr>
            </thead>
            <tbody>
              {invoices.map(inv => (
                <tr key={inv.id}>
                  <td className="break-words max-w-[5rem]">{inv.id}</td>
                  <td className="break-words max-w-[8rem]">{inv.company || '-'}</td>
                  <td className="break-words max-w-[8rem]">{inv.issuer || '-'}</td>
                  <td className="break-words max-w-[6rem]">{inv.date}</td>
                  <td className="break-words max-w-[6rem]">₦{inv.amount.toLocaleString()}</td>
                  <td className="break-words max-w-[5rem]">{inv.status}</td>
                  <td className="break-words max-w-[7rem]"><a href={inv.downloadUrl} className="text-indigo-600 hover:underline">Download</a></td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default Profile;