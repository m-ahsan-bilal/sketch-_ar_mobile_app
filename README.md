# 🖌️ Sketch AR

An immersive **AR Sketching** Flutter app where users can pick sketches from cloud storage (Supabase) and overlay them on live camera to trace or draw in real time.  
Perfect for artists, learners, and creative souls 💫

## ✨ Features

- 📸 **Live Camera Overlay** — Sketch over camera view in real-time.  
- ☁️ **Cloud Storage** with Supabase — Images are fetched dynamically from your Supabase bucket.  
- 🖼️ **Dynamic Sketch Grid** — Displays all uploaded sketches in a clean grid layout.  
- 🧭 **Zoom & Opacity Controls** — Scale and adjust transparency while drawing.  
- ❤️ **Favorite Option** — Mark your favorite sketches.  
- 📱 Works smoothly on both Android and iOS.

---

## 📲 Download APK

👉 [**Download Latest APK**](./build/app/outputs/flutter-apk/app-release.apk)

> *(If you're viewing this on GitHub, click the link to directly download the debug build.)*

---

## 🛠️ Tech Stack

- [Flutter](https://flutter.dev/) 💙  
- [Supabase](https://supabase.com/) ☁️ (for image storage & delivery)  
- [Camera Plugin](https://pub.dev/packages/camera) 📸  
- State Management: `setState` (basic)  

---

## 🚀 Getting Started (Local Development)

### 1. **Clone the repo**

```bash
git clone https://github.com/your-username/sketch_ar.git
cd sketch_ar
