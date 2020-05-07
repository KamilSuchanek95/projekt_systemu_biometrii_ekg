# projekt_systemu_biometrii_ekg
Kody i materiały używane przy projektowaniu przykładowego systemu biometrii opartego o elektryczną aktywność serca. Projekt obejmuje proces od filtracji sygnału po klasyfikację, wraz z uaktualnianiem liczby zarejestrowanych użytkowników. Akwizycja danych zostaje pominięta. Zostaną użyte dane pochodzące z PhysioNet-u [https://www.physionet.org/content/ecgiddb/1.0.0/].

### Aktualna skuteczność dla różnych wariantów sieci:

[Zasób na dysku Google](https://drive.google.com/drive/folders/192AysfLqC6nWTsfSL0D6V3oUZM1sHZVw?usp=sharing)
>v2 ,v7 i v9 są najlepsze.

### Pobieranie danych z Physionet

`download_as_csv.rb` - krótki skrypt Ruby, należy go uruchomić wewnątrz folderu z danymi, pobranymi za jednym razem z serwisu Physionet, wtedy ma sie wewnątrz wiele plików MIT z rozszerzeniami .hea, .dat, .atr, które nie wydały mi się dość zręczne. 
Skrypt należy uruchomić po instalacji programu wfdb na którymkolwiek linuxie, byle nie na wersji WSL, bo to się nie sprawdza, a instalacja wfdb na Windows jest niewarta zachodu... (Może jako pakiet Pythona by to ruszyło, ale nie miałem po co sprawdzać.)

### Aktualne dane z Workspace Matlaba

Znajdują się w folderze głównym i są używane w skrypcie `test_code.m`: 
  - act_layers.mat - struktura sieci
  - act_options.mat - opcje potrzebne przy tworzeniu sieci
  - act_net.mat - obiekt wytrenowanej sieci dla pięciu osób
  - XY_test_train_data_of_5_persons.mat - macierze komórkowe z danymi

### Zapis danych z csv do struktur i segmentacja sygnału na odcinki P-QRS-T

Te zadania realizuje skrypt `projekt_mio.m`

