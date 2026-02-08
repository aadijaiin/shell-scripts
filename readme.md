# 🗄️ Bash Backup Tool

A simple but powerful **Bash-based backup utility** that lets you:

* Back up the **current directory instantly**
* Maintain a **persistent list of backup targets**
* Run **manual or automated (cron) backups** safely
* Store **compressed, timestamped archives**

This project was built as a learning-focused yet production‑style Bash automation tool.

---

## ✨ Features

* 📦 Create `.tar.gz` backups using safe path handling
* 📍 Backup current directory by default (`backup`)
* 🎯 Manage multiple backup targets (`add`, `remove`, `list`)
* 🔁 Backup all registered targets at once (`all`)
* 🧠 Uses `realpath` to avoid path bugs and surprises
* 🗂️ Clean directory structure for backups
* ⏱️ Cron‑friendly design

---

## 📁 Directory Layout

```
~/Desktop/
├── backups/
│   ├── project_backups/
│   │   ├── project_2025-02-08_18-32-10.tar.gz
│   │   └── ...
├── backup_targets
```

* **`backup_targets`** → stores absolute paths of tracked directories
* **`backups/`** → contains per‑directory backup archives

---

## 🚀 Installation

1. Save the script as `backup`
2. Make it executable:

   ```bash
   chmod +x backup
   ```
3. Move it into your PATH:

   ```bash
   sudo mv backup /usr/local/bin/
   ```

Now you can run it from **any directory**.

---

## 🧪 Usage

### 1️⃣ Backup current directory

```bash
backup
```

Backs up the directory you are currently in.

---

### 2️⃣ Backup a specific directory

```bash
backup /path/to/project
```

---

### 3️⃣ Add a directory to tracked targets

```bash
backup add /path/to/project
```

* Stores the absolute path
* Takes an immediate backup

---

### 4️⃣ Remove a tracked target

```bash
backup remove /path/to/project
```

---

### 5️⃣ List all tracked targets

```bash
backup list
```

---

### 6️⃣ Backup all tracked targets

```bash
backup all
```

Ideal for cron jobs.

---

## ⏰ Cron Example

Run all backups every day at 2 AM:

```bash
0 2 * * * /usr/local/bin/backup all >> ~/backup.log 2>&1
```

---

## 🛡️ Safety Notes

* Only **directories** can be backed up
* Paths are normalized using `realpath`
* Backups never escape their target directory
* No root access required

---

## 🧠 Learning Outcomes

This project demonstrates:

* Bash functions & control flow
* Argument parsing & defaults
* Filesystem‑safe scripting
* CLI tool design
* Cron‑ready automation
* Real‑world edge case handling (`.` / `$PWD`)

---

## 📌 Future Improvements (Optional)

* `--help` flag
* Retention policy
* Lockfile support (`flock`)
* Systemd timer
* Package as `.deb` / APT repo

---

## 👤 Author

**Aadi Jain**
Built as part of an intermediate Linux & Bash automation learning journey.

---

## 📜 License

MIT — use it, break it, improve it.
