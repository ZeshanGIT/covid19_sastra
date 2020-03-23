import 'package:flutter/material.dart';

const govt = {
  "Andhra Pradesh": [
    "Sri Venkateswara Institute of Medical Sciences, Tirupati",
    "Rangaraya Medical College, Kakinada",
    "Sidhartha Medical College, Vijaywada"
  ],
  "Assam": [
    "Gauhati Medical College, Guwahati",
    "Regional Medical Research Center, Dibrugarh",
    "Jorhat Medical College, Jorhat",
    "Silchar Medical College, Silchar"
  ],
  "Bihar": [
    "Rajendra Memorial Research Institute of Medical Sciences, Patna",
    "Darbhanga Medical College"
  ],
  "Chandigarh": [
    "Post Graduate Institute of Medical Education & Research, Chandigarh",
    "Govt. Medical College, Chandigarh"
  ],
  "Chattisgarh": [
    "All India Institute of Medical Sciences, Raipur",
    "Late Baliram Kashyap M Govt. Medical College, Jagdalpur"
  ],
  "Delhi": [
    "All India Institute Medical Sciences",
    "Lady Hardinge Medical College",
    "National Centre for Disease Control",
    "Ram Manohar Lohia Hospital",
    "Institute of Liver & Biliary Sciences",
    "Army Hospital Research & Referral"
  ],
  "Gujarat": [
    "BJ Medical College, Ahmedabad",
    "MP Shah Govt Medical College, Jamnagar",
    "Govt. Medical College, Surat",
    "Govt. Medical College, Bhavnagar"
  ],
  "Haryana": [
    "Pt. B.D. Sharma Post Graduate Inst. of Med. Sciences, Rohtak, Haryana",
    "BPS Govt. Medical College, Sonipat"
  ],
  "Himachal Pradesh": [
    "Indira Gandhi Medical College, Shimla",
    "Dr. Rajendra Prasad Govt. Medical College, Tanda"
  ],
  "Jammu & Kashmir": [
    "Govt. Medical College, Jammu",
    "Command Hospital  Udhampur",
    "Sher-i-Kashmir Institute of Medical Sciences, Srinagar",
    "Govt. Medical College, Srinagar"
  ],
  "Jharkhand": ["MGM Medical College & Hospital, Jamshedpur"],
  "Karnataka": [
    "Hassan Inst. of Med. Sciences, Hassan",
    "Mysore Medical College & Research Institute, Mysore",
    "Shimoga Instt. of Medical Sciences, Shivamoga Inst. of Med. Sciences, Shivamogga",
    "Command Hospital (Air Force) Bengaluru",
    "Bangalore Medical College & Research Institute, Bengaluru",
    "National Institute of Virology, Bangalore Field Unit, Bengaluru",
    "Gulbarga Institute of Medical Sciences, Gulbarga"
  ],
  "Kerala": [
    "National Institute of Virology Field Unit, Allapuzzha",
    "Govt. Medical College, Thiruvanathapuram",
    "Govt. Medical College, Kozhikode",
    "Govt. Medical College, Thrissur",
    "Rajiv Gandhi Center for Biotechnology, Thiruvanathapuram",
    "Sree Chitra Tirunal Institute of Medical Sciences, Thiruvanathapuram"
  ],
  "Maharashtra": [
    "National Institute of Virology, Pune",
    "Seth GS Medical College & KEM Hospital, Mumbai",
    "Kasturba Hospital for Infectious Diseases, Mumbai",
    "National Institute of Virology Field Unit, Mumbai",
    "Armed Forces Medical College, Pune",
    "BJ Medical College, Pune",
    "Indira Gandhi Govt. Medical College, Nagpur"
  ],
  "Madhya Pradesh": [
    "All India Institute of Medical Sciences, Bhopal",
    "National Institute for Research on Tribal Health, Jabalpur",
    "Mahatma Gandhi Memorial Medical College, Indore",
    "Govt. Medical College, Bhopal"
  ],
  "Manipur": [
    "Jawaharlal Nehru Institute of Med. Sciences, Imphal-East, Manipur",
    "Regional Institute of Medical Sciences, Imphal"
  ],
  "Meghalaya": [
    "North Eastern Indira Gandhi Regional Institute of Health & Medical Sciences, Shillong, Meghalaya"
  ],
  "Odisha": ["Regional Medical Research Centre, Bhubaneshwar"],
  "Puducherry": [
    "Jawaharlal Institute of Postgraduate Medical Education & Research, Puducherry"
  ],
  "Punjab": [
    "Govt. Medical College, Amritsar",
    "Govt. Medical College, Patiala"
  ],
  "Rajasthan": [
    "Sawai Man Singh Medical College, Jaipur",
    "Dr. Sampurnanand Medical College, Jodhpur",
    "Jhalawar Medical College, Jhalawar",
    "RNT Medical College, Udaipur",
    "SP Medical College, Bikaner",
    "All India Institute of Medical Sciences, Jodhpur",
    "JLN Medical College, Ajmer"
  ],
  "Tamil Nadu": [
    "King Institute of Preventive Medicine & Research, Chennai",
    "Madras Medical College, Chennai",
    "Govt. Theni Medical College, Theni",
    "Tirunelveli Medical College, Tirunelveli",
    "Govt. Medical College, Thiruvarur",
    "Kumar Mangalam Govt. Medical College, Salem",
    "Coimbatore Medical College, Coimbatore"
  ],
  "Telangana": [
    "Gandhi Medical College, Secunderabad",
    "Osmania Medical College, Hyderabad"
  ],
  "Tripura": ["Government Medical College, Agartala"],
  "Uttar Pradesh": [
    "King George Medical University, Lucknow",
    "Institute of Medical Sciences, Banaras Hindu University, Varanasi",
    "Jawaharlal Nehru Medical College, Aligarh",
    "Command Hospital, Lucknow",
    "Uttarakhand",
    "Govt. Medical College, Haldwani"
  ],
  "West Bengal": [
    "National Institute of Cholera & Enteric Diseases, Kolkata",
    "Institute of Post Graduate Medical Education & Research, Kolkata",
    "Midnapore Medical College, Midnapore"
  ],
  "Andaman & Nicobar Islands": ["Regional Medical Research Centre, Port Blair"]
};

const pvt = {
  "Gujarat": [" Unipath Specialty laboratory limited, Ahmedabad"],
  "Karnataka": [" Neuberg Anand Reference Laboratory, Bengaluru"],
  "Maharashtra": [
    " Thyrocare Mumbai",
    "Suburban Diagnostics Mumbai",
    "Metropolis Healthcare Ltd Mumbai",
    " Sir H.N. Reliance, Foundation Hospital and Research Centre, Mumbai",
  ]
};

var dec = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/bg.jpg'),
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
      Colors.black45,
      BlendMode.luminosity,
    ),
  ),
);

var textStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 24,
);
